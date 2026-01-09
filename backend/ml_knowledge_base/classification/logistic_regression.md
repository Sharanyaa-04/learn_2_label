---
id: clf_logistic_001
model: logistic_regression
task_type: classification
category: supervised_learning
difficulty: beginner
question_type: [what,how]
---

## What is Logistic Regression?

Logistic Regression is a classification algorithm that models the probability of a binary outcome using a **logistic (sigmoid) function**.

Despite its name, it is used for classification, not regression.

---

## Type of Problem It Solves

Logistic Regression solves **binary classification** problems and can be extended to multiclass classification.

---

## Core Model Idea

The model computes a weighted sum of inputs and maps it to a probability between 0 and 1.

---

## Loss Function

Logistic Regression typically minimizes **log loss (cross-entropy loss)**, which penalizes incorrect probability estimates.

---

## Key Assumptions

- Linear decision boundary  
- Independent observations  
- Minimal multicollinearity  

---

## Strengths

- Interpretable probabilities  
- Efficient to train  
- Strong baseline for classification  

---

## Limitations

- Cannot model complex nonlinear boundaries  
- Sensitive to outliers and feature scaling  

---

## Training Process

Parameters are learned by minimizing log loss using gradient-based optimization methods.
