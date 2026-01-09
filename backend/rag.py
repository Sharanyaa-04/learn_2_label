from langchain_community.vectorstores import Chroma
from langchain_community.embeddings import SentenceTransformerEmbeddings
from langchain_community.llms import Ollama
from intent import detect_intent

DB_PATH = "vectorstore"

embeddings = SentenceTransformerEmbeddings(
    model_name="all-MiniLM-L6-v2"
)

db = Chroma(
    persist_directory=DB_PATH,
    embedding_function=embeddings
)

llm = Ollama(
    model="mistral",
    temperature=0.2,
)

def format_few_shot(history):
    if not history:
        return ""
    return "\n".join(history[-6:])

def rewrite_query_with_history(query: str, history: list[str] | None) -> str:
    if not history:
        return query

    history_text = "\n".join(history[-6:])

    rewrite_prompt = f"""
You are helping rewrite questions for information retrieval.

Given the previous conversation and the user's latest question,
rewrite the question into a fully self-contained, explicit question.

Do NOT answer the question.
Do NOT add new information.
Only rewrite.

Conversation:
{history_text}

User question:
{query}

Rewritten standalone question:
"""

    rewritten = llm.invoke(rewrite_prompt)
    return str(rewritten).strip()

def answer_query(query: str, history: list[str] | None = None) -> str:
    intent = detect_intent(query)

    if intent == "greeting":
        return (
            "Hello! 😊\n\n"
            "I’m your ML tutor. You can ask me questions about machine learning "
            "concepts like regression, classification, or model evaluation.\n\n"
            "What would you like to learn today?"
        )

    if intent == "meta":
        return (
            "I can help you understand machine learning concepts using "
            "a curated knowledge base.\n\n"
            "Try asking:\n"
            "- What is linear regression?\n"
            "- Explain KNN\n"
            "- What are model assumptions?\n"
        )

    standalone_query = rewrite_query_with_history(query, history)

    docs = db.similarity_search(standalone_query, k=4)

    formula_keywords = ["formula", "equation", "expression"]
    is_formula_question = any(k in query.lower() for k in formula_keywords)
    min_context_length = 120 if is_formula_question else 300

    if not docs or sum(len(d.page_content) for d in docs) < min_context_length:
        return (
            "I don’t have enough information in the knowledge base "
            "to answer this question.\n\n"
            "You can try rephrasing it or ask about another topic."
        )

    context = "\n\n".join(d.page_content for d in docs)
    history_text = format_few_shot(history)

    prompt = f"""

You are a friendly, patient Machine Learning tutor.

Previous examples:
{history_text}

STRICT RULES:
- Use ONLY the context below
- Do NOT use outside knowledge
- If the answer is not present in the context, say you don’t know

STYLE RULES:
- Explain concepts clearly and calmly
- If the answer is longer than 5–6 sentences, break it into sections
- Use short paragraphs (2–3 sentences max)
- Avoid long walls of text
- Use Unicode equations (e.g., ŷ = wX + b)
- Use headings only when they improve clarity

MATH FORMAT RULES:
- Do NOT use LaTeX
- Do NOT use \\hat{{y}}
- Always use Unicode symbols
- Use ŷ = wX + b for equations

FOLLOW-UP RULE:
- End with ONE natural follow-up question
- Do NOT label it

Use previous conversation only as examples of style and intent.
Do NOT treat it as factual knowledge.

Context:
{context}

Question:
{query}

Answer:
"""

    answer = str(llm.invoke(prompt))
    answer = answer.replace(r"\hat{y}", "ŷ").replace(r"\hat y", "ŷ")

    sources = sorted(set(
        d.metadata.get("source", "unknown")
        for d in docs
    ))

    answer += "\n\n---\n**Source(s):** " + ", ".join(sources)
    return answer
