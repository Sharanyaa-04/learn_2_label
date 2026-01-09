import 'quiz_question.dart';

final linearRegressionQuiz = [
  QuizQuestion(
    question: 'What type of output does Linear Regression predict?',
    options: ['Categorical', 'Continuous', 'Binary', 'Text'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'In ŷ = wX + b, what is b?',
    options: ['Slope', 'Intercept', 'Noise', 'Learning rate'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Which loss is typically minimized in Linear Regression?',
    options: ['Cross-entropy', 'Hinge', 'Mean Squared Error', 'Huber always'],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: 'A key assumption of Linear Regression is:',
    options: ['Features are orthogonal', 'Linearity between features and target', 'Target is categorical', 'Data must be standardized'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'R² close to 1 means:',
    options: ['Poor fit', 'Explains most variance', 'Model underfits', 'Coefficients are zero'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'High multicollinearity mainly affects:',
    options: ['Bias', 'Variance of coefficients', 'Learning rate', 'Feature scaling'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Gradient descent updates depend on:',
    options: ['Kernel choice', 'Learning rate and gradients', 'Tree depth', 'Number of neighbors'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Which helps reduce overfitting?',
    options: ['Adding noise only', 'Reducing data size', 'L2 regularization', 'Removing intercept'],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: 'Prediction form of linear regression is:',
    options: ['ŷ = wX + b', 'p = σ(wX)', 'vote of trees', 'distance to neighbors'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Residuals are:',
    options: ['True minus predicted', 'Feature correlations', 'Regularization terms', 'Learning rates'],
    correctIndex: 0,
  ),
];

final ridgeRegressionQuiz = [
  QuizQuestion(
    question: 'Ridge adds which penalty?',
    options: ['L1', 'L2', 'Elastic-net', 'No penalty'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Effect of ridge on coefficients:',
    options: ['Sets many to zero', 'Shrinks but rarely zeroes', 'Grows them', 'Ignores them'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'λ = 0 in ridge yields:',
    options: ['Lasso', 'Logistic regression', 'Ordinary Least Squares', 'Naive Bayes'],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: 'Very large λ typically causes:',
    options: ['Underfitting', 'Overfitting', 'No change', 'Perfect accuracy'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Ridge is helpful when:',
    options: ['Features uncorrelated', 'Strong multicollinearity', 'Only categorical features', 'No numeric features'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Cost function includes:',
    options: ['MSE + λ‖w‖₁', 'MSE + λ‖w‖₂²', 'Only hinge loss', 'Only cross-entropy'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Feature scaling for ridge is:',
    options: ['Unnecessary', 'Recommended', 'Forbidden', 'Only for targets'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Select λ (alpha) typically via:',
    options: ['Manual guess', 'Cross-validation', 'Random label shuffle', 'Tree depth'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Compared to lasso, ridge tends to:',
    options: ['Produce sparse models', 'Keep all features with small weights', 'Drop most features', 'Ignore correlations'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Ridge primarily reduces:',
    options: ['Bias', 'Variance', 'Learning rate', 'Dataset size'],
    correctIndex: 1,
  ),
];

final lassoRegressionQuiz = [
  QuizQuestion(
    question: 'Lasso adds which penalty?',
    options: ['L1', 'L2', 'Elastic-net only', 'No penalty'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Key effect of lasso on coefficients:',
    options: ['Never zeroes', 'Can drive some to zero (feature selection)', 'Always enlarges', 'Ignores magnitude'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Large λ in lasso causes:',
    options: ['More sparsity', 'Less sparsity', 'No change', 'Higher variance'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Lasso vs ridge on multicollinearity:',
    options: ['Lasso keeps all correlated features', 'Lasso may pick one and drop others', 'Same behavior', 'Neither helps'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Cost function includes:',
    options: ['MSE + λ‖w‖₂²', 'MSE + λ‖w‖₁', 'Cross-entropy only', 'No regularization'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'When λ = 0, lasso becomes:',
    options: ['Ridge', 'OLS', 'Logistic regression', 'Naive Bayes'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Feature scaling for lasso is:',
    options: ['Not needed', 'Recommended', 'Forbidden', 'Only for binary features'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Lasso is good for:',
    options: ['Feature selection', 'Increasing variance', 'Removing intercept', 'Handling only categorical'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'If too many features drop, model likely:',
    options: ['Underfits', 'Overfits', 'Is unchanged', 'Improves always'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Elastic-net mixes:',
    options: ['L1 and L2 penalties', 'Two losses', 'Two datasets', 'Two targets'],
    correctIndex: 0,
  ),
];

final logisticRegressionQuiz = [
  QuizQuestion(
    question: 'Logistic regression outputs:',
    options: ['Class labels directly', 'Probabilities via sigmoid', 'Tree splits', 'Distances'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Decision boundary is defined at:',
    options: ['p=0.5 (by default)', 'p=0.9', 'distance=0', 'margin=1'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Loss used for binary logistic regression:',
    options: ['MSE', 'Binary cross-entropy', 'Hinge', 'Huber'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Log-odds are modeled as:',
    options: ['Nonlinear in features', 'Linear in features', 'Quadratic only', 'Tree-based'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Regularization helps:',
    options: ['Overfitting reduction', 'Increase variance', 'Remove bias term always', 'Handle missing data automatically'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'For class imbalance you might:',
    options: ['Ignore labels', 'Use class weights', 'Drop majority class always', 'Increase learning rate only'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Multi-class extension commonly uses:',
    options: ['One-vs-rest', 'Only one-vs-one', 'No extension needed', 'Random forests'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Coefficient sign indicates:',
    options: ['Feature scale', 'Direction of effect on log-odds', 'Tree depth', 'Neighbor count'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Sigmoid squeezes inputs to:',
    options: ['-inf to inf', '0 to 1', '0 to 0.5', '-1 to 1 only'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'High variance in logistic regression can be reduced with:',
    options: ['Higher learning rate', 'More regularization', 'Removing bias term', 'Using fewer samples'],
    correctIndex: 1,
  ),
];

final knnQuiz = [
  QuizQuestion(
    question: 'k-NN is a ______ learner.',
    options: ['Lazy', 'Eager', 'Parametric', 'Tree-based'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Prediction is based on:',
    options: ['Gradient', 'Distance to neighbors', 'Kernel margin', 'Entropy split'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Feature scaling for k-NN is:',
    options: ['Not needed', 'Important', 'Forbidden', 'Only for target'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Large k tends to:',
    options: ['Increase variance', 'Smooth decision boundary (more bias)', 'Reduce bias', 'Remove neighbors'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Common distance metric:',
    options: ['Cosine or Euclidean', 'Hamming only', 'Kullback-Leibler', 'Cross-entropy'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Curse of dimensionality affects k-NN because:',
    options: ['All distances become similar', 'Model is parametric', 'Regularization too strong', 'Gradients vanish'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'For classification, k-NN uses:',
    options: ['Majority vote', 'Averaging labels', 'Maximum margin', 'Entropy minimization'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'For regression, k-NN uses:',
    options: ['Mode', 'Median always', 'Mean of neighbors (often weighted)', 'Sigmoid'],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: 'Prediction time cost is:',
    options: ['Low', 'High (search neighbors)', 'Zero', 'Fixed'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Even k is avoided to:',
    options: ['Reduce bias', 'Avoid ties', 'Increase variance', 'Change metric'],
    correctIndex: 1,
  ),
];

final svmQuiz = [
  QuizQuestion(
    question: 'SVM optimizes for:',
    options: ['Maximum margin', 'Minimum margin', 'Entropy', 'Tree depth'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Support vectors are:',
    options: ['All points', 'Points on/near the margin', 'Centroids', 'Random samples'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'C controls:',
    options: ['Kernel type', 'Tradeoff between margin and misclassification', 'Tree depth', 'Number of neighbors'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Gamma in RBF controls:',
    options: ['Global margin', 'Influence radius of a sample', 'Learning rate', 'Loss type'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Kernel trick allows:',
    options: ['More trees', 'Implicit high-dimensional mapping', 'Lower dimensions always', 'Faster k-NN'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Soft margin SVM allows:',
    options: ['No errors', 'Some misclassification', 'Only linear separable data', 'Tree splits'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Typical loss for SVM is:',
    options: ['Cross-entropy', 'Hinge loss', 'MSE', 'Huber'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'SVMs perform well when:',
    options: ['Huge noisy dataset', 'High-dimensional but not too many samples', 'All features categorical', 'Time series only'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Too large gamma often leads to:',
    options: ['Underfitting', 'Overfitting (very tight boundaries)', 'No change', 'Linear boundary'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Choosing kernel typically via:',
    options: ['Random pick', 'Cross-validation', 'Always RBF', 'Always linear'],
    correctIndex: 1,
  ),
];

final naiveBayesQuiz = [
  QuizQuestion(
    question: 'Naive Bayes assumes:',
    options: ['Features independent given class', 'Features highly correlated', 'Linear decision boundary always', 'No probabilities'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Commonly used for:',
    options: ['Image pixels only', 'Text and word counts', 'Deep nets', 'Time series forecasting'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Handles zero counts via:',
    options: ['Ignoring feature', 'Laplace smoothing', 'Dropping class', 'Scaling to zero'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Gaussian Naive Bayes models features as:',
    options: ['Bernoulli only', 'Multinomial only', 'Normal distributions', 'Uniform'],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: 'Prediction uses:',
    options: ['Posterior probability via Bayes rule', 'Distance to neighbors', 'Margins', 'Entropy gain'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Strengths include:',
    options: ['Slow training', 'Fast training/inference', 'Needs heavy tuning', 'Requires embeddings'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Weakness:',
    options: ['Handles correlated features well', 'Assumes independence which may be false', 'Needs huge data always', 'No probabilistic output'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Class prior affects:',
    options: ['Posterior probabilities', 'Feature scaling', 'Kernel choice', 'Learning rate'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Multinomial NB is suited for:',
    options: ['Continuous features only', 'Counts/frequencies', 'Images', 'Tabular numeric only'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Bernoulli NB expects:',
    options: ['Binary features', 'Real-valued features', 'Images', 'Sequences'],
    correctIndex: 0,
  ),
];

final decisionTreeQuiz = [
  QuizQuestion(
    question: 'Decision trees split to maximize:',
    options: ['Impurity', 'Information gain / impurity reduction', 'Distance', 'Margin'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'ID3 typically uses:',
    options: ['Gini', 'Entropy/information gain', 'Hinge loss', 'MSE'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'CART for classification often uses:',
    options: ['Gini impurity', 'Cross-entropy loss', 'Sigmoid', 'Euclidean distance'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Deep unpruned trees often:',
    options: ['Underfit', 'Overfit', 'Stay optimal', 'Have zero variance'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Pruning helps to:',
    options: ['Increase depth', 'Reduce overfitting', 'Remove regularization', 'Change loss'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Trees handle:',
    options: ['Non-linear relationships', 'Only linear patterns', 'Only images', 'Only text'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Bias towards features with many levels is a risk because:',
    options: ['They reduce entropy arbitrarily', 'They slow training only', 'They remove bias term', 'They fix variance'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Max depth controls:',
    options: ['Learning rate', 'Model complexity', 'Kernel', 'Neighbor count'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'To predict, a tree:',
    options: ['Computes margins', 'Traverses splits to a leaf', 'Uses k neighbors', 'Uses Bayes rule'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Handling missing values is typically done by:',
    options: ['Dropping always', 'Surrogate splits or imputation', 'Setting to zero always', 'Ignoring feature scaling'],
    correctIndex: 1,
  ),
];

final randomForestQuiz = [
  QuizQuestion(
    question: 'Random Forest combines:',
    options: ['Single deep tree', 'Many trees with bagging', 'Only linear models', 'Only boosting'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Feature randomness at splits helps:',
    options: ['Increase correlation between trees', 'Reduce correlation and variance', 'Change loss', 'Remove need for data'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Bootstrap sampling means:',
    options: ['Using validation set', 'Sampling with replacement per tree', 'Dropping half features', 'Bagging only features'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Out-of-bag error is:',
    options: ['Test on same samples', 'Validation on unused samples per tree', 'Train loss', 'Kernel margin'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'More trees generally:',
    options: ['Increase variance', 'Stabilize predictions', 'Always overfit', 'Reduce data'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Max features per split controls:',
    options: ['Learning rate', 'Randomness of each tree', 'Number of trees', 'Depth only'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Random Forest is strong at:',
    options: ['High-dimensional sparse text', 'Tabular data with mixed types', 'Image recognition always', 'Sequence modeling'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'It mainly reduces:',
    options: ['Bias', 'Variance of single trees', 'Data size', 'Need for scaling'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'A drawback is:',
    options: ['Interpretability', 'Cannot handle non-linearity', 'Needs feature scaling', 'Only works for regression'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Feature importance in RF is often computed via:',
    options: ['Gini importance or permutation', 'Sigmoid', 'RBF', 'k distance'],
    correctIndex: 0,
  ),
];
