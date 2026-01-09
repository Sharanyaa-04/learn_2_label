---
id: tree_dt_001
model: decision_tree
task_type: regression,classification
category: supervised_learning
difficulty: beginner
question_type: [what,how]
---

## What is a Decision Tree?

A Decision Tree is a supervised learning algorithm that predicts outcomes by **splitting data into branches based on feature conditions**.

Each internal node represents a decision rule, and each leaf node represents a prediction.

---

## Type of Problems It Solves

Decision Trees can solve both:
- Classification problems
- Regression problems

---

## Core Idea

The model selects features and thresholds that best separate the data at each step, forming a tree of decisions.

---

## Splitting Criterion

Splits are chosen using measures such as:
- Gini impurity or entropy (classification)
- Mean Squared Error (regression)

---

## Strengths

- Easy to interpret and visualize  
- Handles nonlinear relationships  
- Requires little data preprocessing  

---

## Limitations

- Prone to overfitting  
- Sensitive to small changes in data  
- Can grow very complex without constraints  

---

## Training Process

The tree is built recursively by:
1. Selecting the best feature split  
2. Dividing the data  
3. Repeating until stopping criteria are met  

Overfitting is controlled using depth limits or pruning.
