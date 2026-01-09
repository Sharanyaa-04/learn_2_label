---
id: reg_lasso_001
model: lasso_regression
task_type: regression
category: supervised_learning
difficulty: beginner
question_type: [what,why]
---

## What is Lasso Regression?

Lasso Regression is a linear regression variant that includes **L1 regularization** to control model complexity.

---

## Type of Problem It Solves

Lasso Regression solves regression problems where feature selection and sparsity are important.

---

## Core Idea

Lasso Regression penalizes the absolute values of model weights, which can drive some coefficients to zero.

---

## Regularization Term

Lasso Regression adds an L1 penalty to the loss function, encouraging sparse solutions.

---

## Effect of Regularization

- Performs automatic feature selection  
- Reduces overfitting  
- Produces simpler models  

---

## Strengths

- Selects important features  
- Improves interpretability  
- Useful in high-dimensional data  

---

## Limitations

- Can be unstable when features are highly correlated  
- May discard useful features  

---

## Training Process

Parameters are learned by minimizing a regularized loss function using iterative optimization methods.
