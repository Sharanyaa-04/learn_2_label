from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from rag import answer_query
from memory import add_message, get_history
import traceback
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

class ChatRequest(BaseModel):
    question: str
    session_id: str

@app.get("/")
def home():
    return {"status": "RAG API running"}

@app.post("/chat")
def chat(req: ChatRequest):
    try:
        # 1️⃣ Get backend-managed memory
        history = get_history(req.session_id)

        # 2️⃣ Generate answer using RAG + memory
        answer = answer_query(req.question, history)

        # 3️⃣ Store conversation in memory
        add_message(req.session_id, "User", req.question)
        add_message(req.session_id, "Assistant", answer)

        return {"answer": answer}
 
    except Exception as e:
        traceback.print_exc()
        raise HTTPException(
            status_code=500,
            detail="Internal error while generating answer"
        )

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],   # dev/demo
    allow_methods=["*"],
    allow_headers=["*"],
)