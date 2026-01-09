from collections import defaultdict, deque

# Store last 3 Q&A pairs (6 messages) per session
_MEMORY = defaultdict(lambda: deque(maxlen=12))

def add_message(session_id: str, role: str, content: str):
    _MEMORY[session_id].append(f"{role}: {content}")

def get_history(session_id: str):
    return list(_MEMORY[session_id])

def clear_history(session_id: str):
    _MEMORY[session_id].clear()
