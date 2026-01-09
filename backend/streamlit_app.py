import streamlit as st
import requests

API_URL = "http://127.0.0.1:8000/chat"

st.set_page_config(page_title="ML Tutor Bot", layout="centered")

st.title("📚 ML Tutor Bot")
st.caption("Context-grounded answers from your own knowledge base")

if "messages" not in st.session_state:
    st.session_state.messages = []

for msg in st.session_state.messages:
    with st.chat_message(msg["role"]):
        st.markdown(msg["content"])

user_input = st.chat_input("Ask a machine learning question…")

if user_input:
    st.session_state.messages.append({
        "role": "user",
        "content": user_input
    })

    with st.chat_message("user"):
        st.markdown(user_input)

    with st.spinner("Thinking…"):
        try:
            response = requests.post(
                API_URL,
                json={"question": user_input},
                timeout=60
            )

            if response.status_code == 200:
                answer = response.json()["answer"]
            else:
                answer = "❌ Backend error. Is the server running?"

        except Exception:
            answer = (
                "❌ Could not connect to backend.\n\n"
                "Make sure:\n"
                "- FastAPI is running\n"
                "- Ollama is running\n"
                "- Port 8000 is open"
            )

    st.session_state.messages.append({
        "role": "assistant",
        "content": answer
    })

    with st.chat_message("assistant"):
        st.markdown(answer)
import uuid

if "session_id" not in st.session_state:
    st.session_state.session_id = str(uuid.uuid4())

requests.post(
    API_URL,
    json={
        "question": user_input,
        "session_id": st.session_state.session_id
    }
)
