import 'package:flutter/material.dart';

class ComparisonScreen extends StatelessWidget {
  final String group;

  const ComparisonScreen({super.key, required this.group});

  // =========================================================
  // TRANSPOSED + LEARNER-FRIENDLY COMPARISON DATA
  // =========================================================

  static const Map<String, Map<String, dynamic>> _comparisonTables = {
    // ================= REGRESSION =================
    'regression': {
      'title': 'Regression Models',
      'algorithms': [
        'Linear Regression',
        'Ridge Regression',
        'Lasso Regression',
      ],
      'rows': [
        {
          'label': 'Core Idea',
          'Linear Regression': 'Fits a straight line',
          'Ridge Regression': 'Linear model with penalty',
          'Lasso Regression': 'Linear model with feature removal',
        },
        {
          'label': 'Regularization',
          'Linear Regression': 'None',
          'Ridge Regression': 'L2 (shrinks weights)',
          'Lasso Regression': 'L1 (removes weights)',
        },
        {
          'label': 'RMSE (↓)',
          'Linear Regression': '0.35',
          'Ridge Regression': '0.33',
          'Lasso Regression': '0.36',
        },
        {
          'label': 'R² (↑)',
          'Linear Regression': '0.92',
          'Ridge Regression': '0.93',
          'Lasso Regression': '0.91',
        },
        {
          'label': 'Best Use Case',
          'Linear Regression':
              'When output changes in a straight-line pattern',
          'Ridge Regression':
              'When features are related and overfitting occurs',
          'Lasso Regression':
              'When you want the model to ignore unimportant features',
        },
      ],
    },

    // ================= CLASSIFICATION =================
    'classification': {
      'title': 'Classification Models',
      'algorithms': [
        'Logistic Regression',
        'k-NN',
        'SVM',
        'Naive Bayes',
      ],
      'rows': [
        {
          'label': 'Core Idea',
          'Logistic Regression': 'Probability-based classification',
          'k-NN': 'Uses nearest neighbors',
          'SVM': 'Finds best separating boundary',
          'Naive Bayes': 'Uses probability rules',
        },
        {
          'label': 'Model Type',
          'Logistic Regression': 'Parametric',
          'k-NN': 'Non-parametric',
          'SVM': 'Margin-based',
          'Naive Bayes': 'Probabilistic',
        },
        {
          'label': 'Accuracy (↑)',
          'Logistic Regression': '0.96',
          'k-NN': '0.97',
          'SVM': '0.98',
          'Naive Bayes': '0.94',
        },
        {
          'label': 'F1 Score (↑)',
          'Logistic Regression': '0.95',
          'k-NN': '0.96',
          'SVM': '0.97',
          'Naive Bayes': '0.93',
        },
        {
          'label': 'Best Use Case',
          'Logistic Regression':
              'When you need clear yes/no predictions',
          'k-NN':
              'When similar data points belong to the same class',
          'SVM':
              'When classes are clearly separated with many features',
          'Naive Bayes':
              'When working with text or probability-based data',
        },
      ],
    },

    // ================= TREE-BASED =================
    'trees': {
      'title': 'Tree-Based Models',
      'algorithms': [
        'Decision Tree (ID3)',
        'Decision Tree (CART)',
        'Random Forest',
      ],
      'rows': [
        {
          'label': 'Splitting Method',
          'Decision Tree (ID3)': 'Information Gain',
          'Decision Tree (CART)': 'Gini Index',
          'Random Forest': 'Multiple tree splits',
        },
        {
          'label': 'Tree Structure',
          'Decision Tree (ID3)': 'Multi-branch',
          'Decision Tree (CART)': 'Binary splits',
          'Random Forest': 'Many trees combined',
        },
        {
          'label': 'Accuracy (↑)',
          'Decision Tree (ID3)': '0.93',
          'Decision Tree (CART)': '0.95',
          'Random Forest': '0.97',
        },
        {
          'label': 'F1 Score (↑)',
          'Decision Tree (ID3)': '0.92',
          'Decision Tree (CART)': '0.94',
          'Random Forest': '0.96',
        },
        {
          'label': 'Best Use Case',
          'Decision Tree (ID3)':
              'When data is categorical and rules must be clear',
          'Decision Tree (CART)':
              'When both numeric and categorical data are present',
          'Random Forest':
              'When you want high accuracy and stable predictions',
        },
      ],
    },
  };

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final data = _comparisonTables[group];

    if (data == null) {
      return const Scaffold(
        body: Center(child: Text('Comparison not available')),
      );
    }

    final algorithms = List<String>.from(data['algorithms']);
    final rows = List<Map<String, String>>.from(
      data['rows'].map((e) => Map<String, String>.from(e)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Comparison — ${data['title']}'),
        backgroundColor: const Color.fromARGB(255, 247, 247, 248),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: DataTable(
          border: TableBorder.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
          headingRowColor:
              MaterialStateProperty.all(Colors.indigo.shade50),
          columns: [
            const DataColumn(
              label: Text(
                'Comparison Point',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...algorithms.map(
              (algo) => DataColumn(
                label: Text(
                  algo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          rows: rows.map((row) {
            return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                (states) => rows.indexOf(row).isEven
                    ? Colors.grey.shade100
                    : null,
              ),
              cells: [
                DataCell(
                  Text(
                    row['label']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                ...algorithms.map(
                  (algo) => DataCell(
                    Text(
                      row[algo] ?? '-',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
