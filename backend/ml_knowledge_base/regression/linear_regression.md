---
id: reg_linear_001
model: linear_regression
task_type: regression
category: supervised_learning
difficulty: beginner
question_type: [what,how]
---

## What is Linear Regression?

Linear Regression is a regression algorithm that models the relationship between input features and a continuous output using a **linear function**.

---

## Type of Problem It Solves

Linear Regression solves **regression problems** where the relationship between inputs and output is approximately linear.

---

## Core Model Equation

\[
\hat{y} = wX + b
\]

Where:
- \(X\): input features  
- \(w\): weights (slopes)  
- \(b\): bias (intercept)  
- \(\hat{y}\): predicted output  

---

## Loss Function

Linear Regression typically minimizes **Mean Squared Error (MSE)**, which measures the average squared difference between predicted and actual values.

---

## Key Assumptions

- Linear relationship between inputs and output  
- Independence of observations  
- Constant variance of errors  

---

## Strengths

- Simple and interpretable  
- Fast to train  
- Strong baseline model  

---

## Limitations

- Cannot model nonlinear relationships  
- Sensitive to outliers  
- Performance depends on assumptions being met  

---

## Training Process

Model parameters are learned by minimizing the loss function using:
- Closed-form solution (when applicable)
- Gradient descent optimization
