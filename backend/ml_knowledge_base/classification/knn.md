---
id: clf_knn_001
model: k_nearest_neighbors
task_type: classification
category: supervised_learning
difficulty: beginner
question_type: [what,how]
---

## What is k-Nearest Neighbors (k-NN)?

k-Nearest Neighbors is a classification algorithm that assigns a class based on the **majority class of the nearest data points**.

---

## Type of Problem It Solves

k-NN solves classification problems by relying on similarity rather than explicit training.

---

## Core Idea

Predictions are made by finding the k closest points in the training data and voting on their labels.

---

## Key Hyperparameter

- **k**: number of neighbors considered

---

## Strengths

- Simple and intuitive  
- No explicit training phase  
- Adapts to complex decision boundaries  

---

## Limitations

- Computationally expensive at prediction time  
- Sensitive to feature scaling and noise  
- Performance degrades with high dimensionality  

---

## Training Process

k-NN does not learn parameters; it stores training data and computes distances during prediction.
