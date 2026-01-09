import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

// Visualization widgets
import '../widgets/iris_linear_regression.dart';
import '../widgets/iris_logistic_regression.dart';
import '../widgets/iris_knn.dart';
import '../widgets/iris_decision_tree.dart';
import '../widgets/iris_random_forest.dart';
import '../widgets/iris_ridge_regression.dart';
import '../widgets/iris_lasso_regression.dart';
import '../widgets/iris_svm.dart';
import '../widgets/iris_naive_bayes.dart';
import '../quiz/mini_quiz_widget.dart';
import '../quiz/quiz_data.dart';
import '../quiz/quiz_question.dart';
import '../progress/learning_progress.dart';

class AlgorithmScreen extends StatelessWidget {
  final String modelName;

   AlgorithmScreen({
    super.key,
    required this.modelName,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ProgressProvider.of(context);
    const quizPoints = 50;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(modelName),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Explanation'),
              Tab(text: 'Visualization'),
              Tab(text: 'Python Code'),
              Tab(text: 'Quiz'),

            ],
          ),
        ),
        body: TabBarView(
  children: [
    _buildExplanationTab(context),
    _buildVisualizationTab(),
    _buildPythonCodeTab(),

    // ✅ QUIZ TAB (ADD HERE)
    MiniQuiz(
      questions: _getQuizForModel(modelName),
      onCompleted: (score, total) async {
        // Award once per algorithm when quiz is finished (transactional in Firestore)
        final success = await progress.awardCompletion(modelName, points: quizPoints);
        if (!success && progress.lastError != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(progress.lastError!)),
          );
        }
        return success;
      },
    ),
  ],
),

      ),
    );
  }

  // =========================================================
  // EXPLANATION TAB
  // =========================================================

  Widget _buildExplanationTab(BuildContext context) {
  final content = _explanationData[modelName];

  if (content == null) {
    return const Center(child: Text('Explanation not available'));
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(
          icon: Icons.trending_up,
          title: 'What is ${modelName}?',
          children: [
            _paragraph(content['definition']!),
          ],
        ),

        _section(
          icon: Icons.lightbulb_outline,
          title: 'Key Idea',
          children: [
            _paragraph(content['keyIdea']!),
          ],
        ),

        _section(
          icon: Icons.list_alt,
          title: 'Important Characteristics',
          children: content['characteristics']!
              .map<Widget>((e) => _bullet(e))
              .toList(),
        ),

        _section(
          icon: Icons.settings,
          title: content['processTitle']!,
          children: content['process']!
              .map<Widget>((e) => _bullet(e))
              .toList(),
        ),

        // ✅ FORMULA (unchanged)
        formulaBox(context,
            content['formula'],
            content['formulaDetails'],
          ),

        if (content['evaluationMetrics'] != null)
          _section(
            icon: Icons.assessment_outlined,
            title: 'Evaluation Metrics',
            children: (content['evaluationMetrics'] as List<dynamic>)
                .map<Widget>((e) => _bullet(e as String))
                .toList(),
          ),

        // ✅ SUMMARY (unchanged)
        _summaryBox(content['summary']!),
        if (content.containsKey('nodeLogic')) 
  _section(
    icon: Icons.account_tree,
    title: content['nodeLogicTitle'],
    children: content['nodeLogic']
        .map<Widget>((e) => _bullet(e))
        .toList(),
  ),

      ],
    ),
  );
}


  // =========================================================
  // VISUALIZATION TAB
  // =========================================================

  Widget _buildVisualizationTab() {
    switch (modelName) {
      case 'Linear Regression':
        return const IrisLinearRegression();
      case 'Ridge Regression':
        return const IrisRidgeRegression();
      case 'Lasso Regression':
        return const IrisLassoRegression();
      case 'Logistic Regression':
        return const IrisLogisticRegression();
      case 'k-NN':
        return const IrisKNN();
      case 'SVM':
        return const IrisSVM();
      case 'Naive Bayes':
        return const IrisNaiveBayes();
      case 'Decision Tree (ID3)':
      case 'Decision Tree (CART)':
        return const IrisDecisionTree();
      case 'Random Forest':
        return const IrisRandomForest();
      default:
        return const Center(child: Text('Visualization not available'));
    }
  }

  // =========================================================
  // PYTHON CODE TAB
  // =========================================================

  Widget _buildPythonCodeTab() {
    final pythonCode = {
      'Linear Regression': '''
# y = mx + c

def train_linear_regression(X, y):
    n = len(X)
    x_mean = sum(X) / n
    y_mean = sum(y) / n

    num = sum((X[i] - x_mean) * (y[i] - y_mean) for i in range(n))
    den = sum((X[i] - x_mean) ** 2 for i in range(n))

    m = num / den
    c = y_mean - m * x_mean
    return m, c

def predict(x, m, c):
    return m * x + c

''',
      'Ridge Regression': '''# Penalizes large weights

def ridge_regression(m, lambda_):
    return m / (1 + lambda_)
''',
      'Lasso Regression': '''# Shrinks small weights to zero

def lasso(weights, threshold):
    return [0 if abs(w) < threshold else w for w in weights]
''',

      'Logistic Regression': '''
import math

def sigmoid(z):
    return 1 / (1 + math.exp(-z))

def predict_probability(x, w, b):
    z = w * x + b
    return sigmoid(z)

def classify(x, w, b):
    return 1 if predict_probability(x, w, b) >= 0.5 else 0

''',

      'k-NN': '''
import math

def euclidean_distance(a, b):
    return math.sqrt(sum((a[i] - b[i]) ** 2 for i in range(len(a))))

def knn_predict(X_train, y_train, x_test, k):
    distances = []
    for i in range(len(X_train)):
        d = euclidean_distance(X_train[i], x_test)
        distances.append((d, y_train[i]))

    distances.sort()
    neighbors = distances[:k]
    labels = [label for _, label in neighbors]
    return max(set(labels), key=labels.count)
''',

      'SVM': '''# SVM focuses on maximizing margin
# Simplified decision function

def svm_decision(x, w, b):
    return w * x + b

def svm_predict(x, w, b):
    return 1 if svm_decision(x, w, b) >= 0 else -1
''',

      'Naive Bayes': '''def naive_bayes(prior, likelihoods):
    prob = prior
    for p in likelihoods:
        prob *= p
    return prob

# Example:
# P(Class|X) ∝ P(Class) × ΠP(xi|Class)

''',

'Decision Tree (ID3)': '''
import math

def entropy(p):
    return -sum(x * math.log2(x) for x in p if x != 0)

def information_gain(parent, children):
    total = sum(children)
    weighted_entropy = sum(
        (child / total) * entropy([child / total])
        for child in children
    )
    return entropy(parent) - weighted_entropy

''',

'Decision Tree (CART)': '''
# CART uses Gini Index
def gini(groups, classes):
    n = sum(len(group) for group in groups)
    return sum(
        (len(group)/n) * (1 - sum((row[-1]==c)**2 for c in classes))
        for group in groups
    )
''',
      'Random Forest': '''def majority_vote(predictions):
    return max(set(predictions), key=predictions.count)

# Train multiple trees on random samples
# Final prediction = majority vote
''',

    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SelectableText(
        pythonCode[modelName] ?? 'Code not available.',
        style: const TextStyle(fontFamily: 'monospace'),
      ),
    );
  }

  // =========================================================
  // UI HELPERS
  // =========================================================

  Widget _section({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      childrenPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: children,
    );
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, height: 1.6),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget formulaBox(
  BuildContext context,
  String latexFormula,
  List<String>? details,) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 24),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey.shade900 : Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isDark ? Colors.grey : Colors.blue.shade300,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Formula',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Math.tex(
            latexFormula,
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),

        if (details != null) ...[
          const SizedBox(height: 12),
          const Text(
            'Where:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          ...details.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('• $d'),
            ),
          ),
        ],
      ],
    ),
  );
}



  Widget _summaryBox(String text) {
  return Builder(
    builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      return Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E3A2F)   // dark green surface
              : Colors.green.shade50,     // light green surface
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.greenAccent.shade200
                : Colors.green.shade300,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: isDark
                  ? Colors.greenAccent.shade200
                  : Colors.green,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  final Map<String, Map<String, dynamic>> _explanationData = {
  'Linear Regression': {
    'definition':
        'Linear Regression predicts a continuous output by learning a straight-line relationship between input features and the target value. '
'It works best when the relationship between variables is approximately linear.',
    'keyIdea':
        'The algorithm fits a straight line that minimizes the error between '
        'predicted and actual values.',
    'characteristics': [
      'Supervised learning algorithm',
      'Used for regression problems',
      'Assumes linear relationship',
      'Sensitive to outliers',
    ],
    'processTitle': 'Training Process',
    'process': [
      'Initialize model parameters',
      'Compute predictions',
      'Calculate Mean Squared Error',
      'Optimize parameters using gradient descent',
    ],
    'formula': r'y = mx + c',
    'formulaDetails': [
    'y → predicted output value',
    'x → input feature',
    'm → slope (model weight)',
    'c → intercept (bias)',
  ],
    'evaluationMetrics': [
      'Mean Squared Error (MSE) - Lower MAE indicates better model performance, as predictions are closer to actual values. ',
      'Root Mean Squared Error (RMSE) - A smaller MSE value means fewer large errors and better overall prediction accuracy.',
      'Mean Absolute Error (MAE) - Lower RMSE indicates better model fit and is easier to interpret since it uses the same units as the target.',
      'R-squared (R2) - An R² value closer to 1 indicates the model explains most of the variance in the data.',
    ],
    'summary':
        'Linear Regression is best suited for predicting continuous values '
        'when a linear relationship exists between variables.',
  },

  'Lasso Regression': {
  'definition':
      'Lasso Regression adds a penalty that can shrink some coefficients exactly to zero.'
'Because of this, it not only reduces overfitting but also helps in automatic feature selection.',
  'keyIdea':
      'By applying L1 regularization, it performs both regression and '
      'feature selection.',
  'characteristics': [
    'Uses L1 regularization',
    'Can remove irrelevant features',
    'Produces sparse models',
  ],
  'processTitle': 'Training Process',
  'process': [
    'Compute predictions',
    'Apply L1 penalty to coefficients',
    'Optimize using gradient descent',
  ],
  'formula': r'\min \sum (y - \hat{y})^2 + \lambda \sum |w|',
  'formulaDetails': [
    'y → actual output value',
    'ŷ → predicted output value',
    'w → model coefficients(weights)',
    'λ(lambda) → Controls amount of regularization',
  ],
  'evaluationMetrics': [
    'Mean Squared Error (MSE) - Lower MAE indicates better model performance, as predictions are closer to actual values. ',
      'Root Mean Squared Error (RMSE) - A smaller MSE value means fewer large errors and better overall prediction accuracy.',
      'Mean Absolute Error (MAE) - Lower RMSE indicates better model fit and is easier to interpret since it uses the same units as the target.',
      'R-squared (R2) - An R² value closer to 1 indicates the model explains most of the variance in the data.',
    ],
  
  'summary':
      'Lasso Regression is ideal when feature selection and model simplicity '
      'are important.',
},


  'Ridge Regression': {
  'definition':
      'Ridge Regression extends Linear Regression by adding a penalty for large coefficients.'
'This helps control model complexity and reduces overfitting, especially when features are highly correlated.',
  'keyIdea':
      'It discourages complex models by shrinking coefficients, helping '
      'to reduce overfitting.',
  'characteristics': [
    'Uses L2 regularization',
    'Reduces model variance',
    'Keeps all features in the model',
  ],
  'processTitle': 'Training Process',
  'process': [
    'Compute predictions using linear model',
    'Calculate loss with L2 penalty',
    'Update coefficients using gradient descent',
  ],
  'formula': r'\min \sum (y - \hat{y})^2 + \lambda \sum w^2',
  'formulaDetails': [
    'y → actual output value',
    'ŷ → predicted output value',
    'w → model coefficients(weights)',
    'λ(lambda) → Regularization parameter controlling penalty strength',
  ],
  'evaluationMetrics': [
    'Mean Squared Error (MSE) - Lower MAE indicates better model performance, as predictions are closer to actual values. ',
      'Root Mean Squared Error (RMSE) - A smaller MSE value means fewer large errors and better overall prediction accuracy.',
      'Mean Absolute Error (MAE) - Lower RMSE indicates better model fit and is easier to interpret since it uses the same units as the target.',
      'R-squared (R2) - An R² value closer to 1 indicates the model explains most of the variance in the data.',
    ],
  'summary':
      'Ridge Regression is useful when multicollinearity exists and '
      'overfitting needs to be controlled.',
},


  'Logistic Regression': {
    'definition':
        'Logistic Regression is a classification algorithm that predicts probabilities using a sigmoid function.'
'Based on a threshold, it assigns inputs to different classes.',
    'keyIdea':
        'It uses the sigmoid function to map inputs to probabilities '
        'between 0 and 1.',
    'characteristics': [
      'Used for binary classification',
      'Outputs probability values',
      'Uses a threshold for class decision',
    ],
    'processTitle': 'Training Process',
    'process': [
      'Compute weighted sum of inputs',
      'Apply sigmoid function',
      'Calculate log-loss',
      'Update weights using gradient descent',
    ],
    'formula': r'P(y=1|x) = \frac{1}{1 + e^{-z}}',
    'formulaDetails': [
      'P(y=1|x) → Probability of the positive class',
      'z → Weighted sum of inputs (z = w·x + b)',   
      'e → Euler’s number (≈ 2.718)',
    ],
    'evaluationMetrics': [
      'Accuracy - Higher accuracy indicates a greater proportion of correct predictions.',

      'Precision - Higher precision means fewer false positives in the model’s predictions.',

      'Recall - Higher recall indicates the model correctly identifies most of the actual positive cases.',         
      'F1 Score - A higher F1 score indicates a good balance between precision and recall.',  

      'ROC–AUC - An AUC value closer to 1 indicates excellent class separation ability.',
    ],
    'summary':
        'Logistic Regression is ideal for binary classification problems '
        'where probability estimation is required.',
  },

  'k-NN': {
    'definition':
        'k-NN classifies a data point by looking at the labels of its nearest neighbors.'
'It does not build an explicit model and relies entirely on the training data.',
    'keyIdea':
        'Classification is done by majority voting among the k closest points.',
    'characteristics': [
      'No explicit training phase',
      'Distance-based algorithm',
      'Sensitive to choice of k',
    ],
    'processTitle': 'Working Process',
    'process': [
      'Choose value of k',
      'Compute distance to all points',
      'Select k nearest neighbors',
      'Assign majority class',
    ],
    'formula': r'd = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2}',
    'formulaDetails': [
      'd → Distance between two points',
      'x₁, y₁ → Coordinates of first point',
      'x₂, y₂ → Coordinates of second point',
    ],
    'evaluationMetrics': [
      'Accuracy - Higher accuracy indicates a greater proportion of correct predictions.',

      'Precision - Higher precision means fewer false positives in the model’s predictions.',

      'Recall - Higher recall indicates the model correctly identifies most of the actual positive cases.',         
      'F1 Score - A higher F1 score indicates a good balance between precision and recall.',  

      'ROC–AUC - An AUC value closer to 1 indicates excellent class separation ability.',
    ],
    'summary':
        'k-NN is simple and intuitive but can be computationally expensive '
        'for large datasets.',
  },

  'SVM': {
  'definition':
      'SVM finds the best decision boundary that separates classes with the maximum margin.'
'It is effective in high-dimensional spaces and works well with clear class boundaries.',
  'keyIdea':
      'It finds the decision boundary that maximizes the margin between '
      'different classes.',
  'characteristics': [
    'Effective in high-dimensional spaces',
    'Uses support vectors to define boundary',
    'Can handle non-linear data using kernels',
  ],
  'processTitle': 'Training Process',
  'process': [
    'Select optimal hyperplane',
    'Maximize margin between classes',
    'Apply kernel trick if data is non-linear',
  ],
  'formula': r'\max \; \frac{2}{\lVert w \rVert}',
  'formulaDetails': [
    'w → Weight vector defining the hyperplane',
    '||w|| → Magnitude of the weight vector',
    'Maximizing the expression increases the margin',
  ],
  'evaluationMetrics': [
      'Accuracy - Higher accuracy indicates a greater proportion of correct predictions.',

      'Precision - Higher precision means fewer false positives in the model’s predictions.',

      'Recall - Higher recall indicates the model correctly identifies most of the actual positive cases.',         
      'F1 Score - A higher F1 score indicates a good balance between precision and recall.',  

      'ROC–AUC - An AUC value closer to 1 indicates excellent class separation ability.',
    ],
  'summary':
      'SVM is powerful for complex classification tasks where clear '
      'separation between classes is needed.',
},

'Naive Bayes': {
  'definition':
      'Naive Bayes is a probabilistic classifier based on Bayes’ theorem.'
'It assumes features are independent, which makes it simple, fast, and surprisingly effective.',
  'keyIdea':
      'It assumes that features are conditionally independent given the class.',
  'characteristics': [
    'Fast and scalable',
    'Works well with high-dimensional data',
    'Assumes feature independence',
  ],
  'processTitle': 'Training Process',
  'process': [
    'Calculate prior probabilities',
    'Estimate likelihood of features',
    'Compute posterior probability',
  ],
  'formula': r'P(C|X) \propto P(C)\prod P(x_i|C)',
  'formulaDetails': [
    'P(C|X) → Posterior probability of class C given features X',
    'P(C) → Prior probability of class C',
    'P(xᵢ|C) → Likelihood of feature xᵢ given class C',
  ],
  'evaluationMetrics': [
      'Accuracy - Higher accuracy indicates a greater proportion of correct predictions.',

      'Precision - Higher precision means fewer false positives in the model’s predictions.',

      'Recall - Higher recall indicates the model correctly identifies most of the actual positive cases.',         
      'F1 Score - A higher F1 score indicates a good balance between precision and recall.',  

      'ROC–AUC - An AUC value closer to 1 indicates excellent class separation ability.',
    ],
  'summary':
      'Naive Bayes is simple, fast, and effective for text and probabilistic '
      'classification tasks.',
},

'Decision Tree (ID3)': {
  'definition':
      'ID3 (Iterative Dichotomiser 3) builds a decision tree by selecting features with the highest Information Gain at each step.'
'It mainly works with categorical data and uses entropy to measure how well a feature splits the data.',
  'keyIdea':
      'The algorithm selects the feature that provides the highest '
      'Information Gain at each split.',
  'characteristics': [
    'Uses Information Gain as splitting criterion',
    'Works only with categorical features',
    'Does not support pruning',
  ],
  'nodeLogicTitle': 'How are nodes decided?',
  'nodeLogic': [
    'Root node is chosen as the feature with the highest Information Gain.',
    'Information Gain measures how much uncertainty is reduced after a split.',
    'Leaf node is created when all data points belong to the same class.',
    'Leaf node is also created when no features remain for further splitting.',
  ],
  'processTitle': 'Training Process',
  'process': [
    'Calculate entropy of the dataset',
    'Compute information gain for each feature',
    'Split on the feature with highest gain',
    'Repeat recursively until stopping condition',
  ],
  'formula': r'IG(S, A) = H(S) - \sum p(S_v)H(S_v)',
  'formulaDetails': [
    'IG(S, A) → Information Gain of feature A on dataset S',
    'H(S) → Entropy of dataset S',
    'Sᵥ → Subset created by attribute A',
  ],
  'evaluationMetrics': [
    'Information Gain (ID3) - Higher information gain leads to better feature splits and improved classification.',

    'Gini Index (CART) - Lower Gini index values indicate purer nodes and better splits.',      
'Out-of-Bag (OOB) Error - Lower OOB error indicates better generalization performance in Random Forests.',  
  ],
  'summary':
      'ID3 builds trees using entropy reduction, but can easily overfit '
      'and does not handle continuous data directly.',
},

'Decision Tree (CART)': {
  'definition':
      'CART (Classification and Regression Trees) constructs decision trees using the Gini Index or Mean Squared Error.'
'It always produces binary splits and supports both classification and regression tasks.',
  'keyIdea':
      'The algorithm splits data using the Gini Index to minimize impurity.',
  'characteristics': [
    'Uses Gini Index as splitting criterion',
    'Supports numerical and categorical features',
    'Produces binary trees',
  ],
  'nodeLogicTitle': 'How are nodes decided?',
  'nodeLogic': [
    'Root node is chosen as the feature with the lowest Gini Index.',
    'Gini Index measures impurity of a node.',
    'Binary splits are applied at every node.',
    'Leaf node represents the final class or value when stopping conditions are met.',
  ],
  'processTitle': 'Training Process',
  'process': [
    'Compute Gini impurity for each possible split',
    'Choose split with lowest impurity',
    'Create binary splits',
    'Prune tree to reduce overfitting',
  ],
  'formula': r'Gini = 1 - \sum p_i^2',
  'formulaDetails': [
    'pᵢ → Proportion of class i in the node',
    'Gini measures the impurity of a dataset',
    'Lower Gini value means purer node',
  ],
  'evaluationMetrics': [
    'Accuracy on validation set',
    'Precision/Recall/F1 for classification',
    'ROC-AUC for binary outputs',
    'Pruning decision via validation loss or CV score',
  ],
  'summary':
      'CART is more flexible than ID3 and is widely used in practical '
      'machine learning applications.',
},


  'Random Forest': {
    'definition':
        'Random Forest is an ensemble method that builds multiple decision trees and combines their predictions.'
'This improves accuracy and reduces overfitting compared to a single tree.',
    'keyIdea':
        'Predictions are made using majority voting across trees.',
    'characteristics': [
      'Reduces overfitting',
      'Handles large datasets well',
      'More accurate than a single tree',
    ],
    'processTitle': 'Training Process',
    'process': [
      'Create multiple bootstrap samples',
      'Train a decision tree on each sample',
      'Aggregate predictions',
    ],
    'formula': r'\text{Majority voting of trees}',
    'formulaDetails': [
      'Each tree votes for a class',
      'Final prediction is the class with most votes',
    ],
    'evaluationMetrics': [
      'Out-of-bag (OOB) error estimate',
      'Accuracy on validation or test data',
      'Precision/Recall/F1 and ROC-AUC',
      'Confusion matrix to spot systematic errors',
    ],
    'summary':
        'Random Forest improves accuracy and stability by combining '
        'multiple decision trees.',
  },
};

List<QuizQuestion> _getQuizForModel(String modelName) {
  switch (modelName) {
    case 'Linear Regression':
      return linearRegressionQuiz;
    case 'Ridge Regression':
      return ridgeRegressionQuiz;
    case 'Lasso Regression':
      return lassoRegressionQuiz;
    case 'Logistic Regression':
      return logisticRegressionQuiz;
    case 'k-NN':
      return knnQuiz;
    case 'SVM':
      return svmQuiz;
    case 'Naive Bayes':
      return naiveBayesQuiz;
    case 'Decision Tree (ID3)':
    case 'Decision Tree (CART)':
      return decisionTreeQuiz;
    case 'Random Forest':
      return randomForestQuiz;
    default:
      return [];
  }
}

}

