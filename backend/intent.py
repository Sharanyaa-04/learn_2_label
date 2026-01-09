import re

GREETING_PATTERNS = [
    r"\bhi\b",
    r"\bhello\b",
    r"\bhey\b",
    r"\bgood morning\b",
    r"\bgood evening\b",
    r"\bhow are you\b",
]

META_PATTERNS = [
    r"\bwhat can you do\b",
    r"\bhelp\b",
    r"\bwho are you\b",
]

def detect_intent(text: str) -> str:
    text = text.lower().strip()

    for pattern in GREETING_PATTERNS:
        if re.search(pattern, text):
            return "greeting"

    for pattern in META_PATTERNS:
        if re.search(pattern, text):
            return "meta"

    return "question"
