# 📘 LABEL 2 LEARN

An interactive educational platform designed to help students **learn, visualize, compare, and practice supervised machine learning algorithms** through structured content, visualizations, quizzes, and real-world problem statements.

---

## 🚀 Project Overview

This project focuses on **Supervised Learning** and provides:

- Conceptual explanations
- Interactive visualizations
- Algorithm-wise comparisons
- Progressive learning with locks & rewards
- Practice-oriented problem statements
- AI Tutor (Chatbot) support

The platform is built to encourage **step-by-step learning** rather than passive content consumption.

---

## 🎯 Objectives

- Help beginners understand supervised learning concepts clearly
- Prevent random skipping of topics using **progressive unlocking**
- Encourage **application-based learning**
- Provide an intuitive UI suitable for students
- Support both **web (Chrome)** and **desktop** platforms

---

## 🧠 Covered Topics

### 🔹 Machine Learning Basics
- What is Machine Learning?
- Supervised vs Unsupervised vs Reinforcement Learning
- Features and Target variables
- Training, Validation, and Test sets
- Overfitting and Underfitting
- Bias–Variance tradeoff
- Data preprocessing concepts

### 🔹 Supervised Learning Algorithms

#### Regression
- Linear Regression  
- Ridge Regression  
- Lasso Regression  

#### Classification
- Logistic Regression  
- k-Nearest Neighbors (k-NN)  
- Support Vector Machine (SVM)  
- Naive Bayes  

#### Tree-Based
- Decision Tree (ID3)  
- Decision Tree (CART)  
- Random Forest  

---

## 📊 Visualizations

Each algorithm includes:
- Interactive plots
- Dataset-based demonstrations
- Clear decision boundaries or regression trends
- Support for dark and light modes

Datasets used are intentionally **small and educational**, such as:
- Iris Dataset
- House Price Dataset

---

## 🧪 Practice Problems Section

A dedicated **Practice Problems** section allows students to apply their learning.

Each problem includes:
- Real-world context
- Dataset description
- Step-by-step guidance on what to do
- No direct solutions provided

This ensures **active learning** and critical thinking.

---

## 🏆 Gamification & Progress Tracking

- Algorithms are **locked initially**
- Users unlock the next algorithm by:
  - Completing quizzes
- Points are awarded per completion
- Progress is synced using **Firebase Firestore**
- Visual feedback for unlocked/completed modules

---

## 🤖 AI Tutor (Chatbot)

- Integrated AI Tutor to answer ML-related questions
- Backend powered by:
  - FastAPI
  - Ollama (Mistral)
  - RAG-based retrieval
- Frontend communicates via REST API
- Designed to assist, not replace learning

---

## 📈 Algorithm Comparison

A comparison module allows students to:
- Compare algorithms within the same category
- Understand strengths, weaknesses, and use-cases
- Learn when to prefer one model over another

---

## 🧩 Tech Stack

### Frontend
- Flutter (Web & Desktop)
- Material UI
- fl_chart
- flutter_math_fork

### Backend
- FastAPI
- Ollama (Mistral)
- LangChain (RAG)
- Sentence Transformers

### Database & Auth
- Firebase Authentication
- Cloud Firestore

---

## 🌗 UI & Accessibility

- Light Mode and Dark Mode toggle
- Student-friendly color palette
- Responsive layout for web
- Drawer-based navigation menu

---

## 🧪 Evaluation Metrics Covered

- Regression: MAE, MSE, RMSE, R²
- Classification: Accuracy, Precision, Recall, F1-score, ROC–AUC
- Tree-based: Information Gain, Gini Index, OOB Error

---

## 🧑‍🎓 Team Contribution

- **Student 1 (AIML)** – Frontend development, UI/UX, visualizations  
- **Student 2 (AIML)** – Backend, AI Tutor, model integration  
- **Student 3 (ECE)** – Testing, usability feedback, user perspective  

---

## 📌 How to Run (Frontend) 
flutter pub get
flutter run -d chrome

## 📌 How to Run (Backend)
pip install -r requirements.txt
uvicorn app:app --reload
(or)
uvicorn app:app --host 0.0.0.0 --port 8001
