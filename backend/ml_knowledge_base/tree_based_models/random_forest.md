---
id: tree_rf_001
model: random_forest
task_type: regression,classification
category: supervised_learning
difficulty: beginner
question_type: [what,why]
---

## What is a Random Forest?

A Random Forest is an ensemble learning algorithm that combines **multiple decision trees** to improve prediction accuracy and stability.

---

## Type of Problems It Solves

Random Forest can solve:
- Classification problems
- Regression problems

---

## Core Idea

The model trains many decision trees on different subsets of data and features, then aggregates their predictions.

---

## Ensemble Mechanism

- Each tree is trained on a random sample of the data  
- Feature selection is randomized at each split  
- Predictions are combined by voting (classification) or averaging (regression)

---

## Strengths

- Reduces overfitting compared to single trees  
- Handles nonlinear relationships well  
- Works with high-dimensional data  

---

## Limitations

- Less interpretable than a single decision tree  
- Higher computational cost  
- Larger memory usage  

---

## Training Process

Training involves:
1. Creating multiple bootstrapped datasets  
2. Training a decision tree on each dataset  
3. Aggregating predictions across all trees  

The ensemble improves generalization by reducing variance.
