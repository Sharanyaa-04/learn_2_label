---
id: reg_ridge_001
model: ridge_regression
task_type: regression
category: supervised_learning
difficulty: beginner
question_type: [what,why]
---

## What is Ridge Regression?

Ridge Regression is a linear regression variant that includes **L2 regularization** to reduce model complexity.

---

## Type of Problem It Solves

Ridge Regression solves regression problems where multicollinearity or overfitting is a concern.

---

## Core Idea

Ridge Regression penalizes large model weights, encouraging smaller and more stable coefficients.

---

## Regularization Term

Ridge Regression adds an L2 penalty to the loss function, which discourages large parameter values.

---

## Effect of Regularization

- Reduces variance  
- Improves generalization  
- Does not eliminate features entirely  

---

## Strengths

- Handles multicollinearity well  
- More stable than standard linear regression  
- Better generalization in noisy data  

---

## Limitations

- Less interpretable than standard linear regression  
- Requires tuning of regularization strength  

---

## Training Process

Parameters are learned by minimizing a regularized loss function using gradient-based optimization.
