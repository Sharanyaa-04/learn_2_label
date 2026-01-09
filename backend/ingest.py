import os
import frontmatter

from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_community.embeddings import SentenceTransformerEmbeddings
from langchain_community.vectorstores import Chroma

KB_PATH = "ml_knowledge_base"
DB_PATH = "vectorstore"


def sanitize_metadata(metadata: dict) -> dict:
    """
    Convert metadata into Chroma-safe primitives only.
    """
    clean = {}
    for key, value in metadata.items():
        if isinstance(value, list):
            clean[key] = ", ".join(map(str, value))
        elif isinstance(value, dict):
            clean[key] = str(value)
        elif isinstance(value, (str, int, float, bool)) or value is None:
            clean[key] = value
        else:
            clean[key] = str(value)
    return clean


def load_markdown_files():
    docs = []

    for root, _, files in os.walk(KB_PATH):
        for file in files:
            if not file.endswith(".md"):
                continue

            path = os.path.join(root, file)
            post = frontmatter.load(path)

            metadata = sanitize_metadata({
                **post.metadata,
                "source": path
            })

            docs.append({
                "content": post.content,
                "metadata": metadata
            })

    return docs


def ingest():
    splitter = RecursiveCharacterTextSplitter(
        chunk_size=500,
        chunk_overlap=100
    )

    embeddings = SentenceTransformerEmbeddings(
        model_name="all-MiniLM-L6-v2"
    )

    texts = []
    metadatas = []

    for doc in load_markdown_files():
        chunks = splitter.split_text(doc["content"])
        for chunk in chunks:
            texts.append(chunk)
            metadatas.append(doc["metadata"])

    db = Chroma.from_texts(
        texts=texts,
        metadatas=metadatas,
        embedding=embeddings,
        persist_directory=DB_PATH
    )

    db.persist()
    print("✅ Ingestion complete (metadata is Chroma-safe)")


if __name__ == "__main__":
    ingest()
