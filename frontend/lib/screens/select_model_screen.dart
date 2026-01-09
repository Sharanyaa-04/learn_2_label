import 'package:flutter/material.dart';
import 'algorithm_screen.dart';
import 'comparison_screen.dart';

class SelectModelScreen extends StatelessWidget {
  const SelectModelScreen({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget modelTile(
    BuildContext context,
    String modelName,
    String description,
  ) {
    // Unlock all models for now (progress tracking not wired)
    const unlocked = true;

  return Card(
    child: ListTile(
      title: Text(modelName),
      subtitle: Text(description),
      trailing:
          unlocked ? const Icon(Icons.arrow_forward) : const Icon(Icons.lock),
      onTap: unlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AlgorithmScreen(
                    modelName: modelName,
                  ),
                ),
              );
            }
          : null,
    ),
  );
}

  Widget comparisonTile(
    BuildContext context,
    String title,
    String group,
  ) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: const Text('Compare algorithms side by side'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ComparisonScreen(group: group),
            ),
          );
        },
      ),
    );
  }

  Widget datasetInfoCard(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isDark ? Colors.blueGrey : Colors.blue.shade200,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.dataset,
          color: isDark ? Colors.lightBlueAccent : Colors.blue,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Dataset Used',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Iris Dataset',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '150 samples • 4 features • 3 classes\n'
                'Features: Sepal length, Sepal width, '
                'Petal length, Petal width',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
Widget _datasetTable(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: isDark ? Colors.white : Colors.black,
  );

  final cellStyle = TextStyle(
    fontSize: 13.5,
    color: isDark ? Colors.white70 : Colors.black87,
  );

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      headingRowColor: WidgetStateProperty.all(
        isDark ? Colors.grey.shade800 : Colors.blue.shade50,
      ),
      columns: [
        DataColumn(label: Text('Sepal L', style: headerStyle)),
        DataColumn(label: Text('Sepal W', style: headerStyle)),
        DataColumn(label: Text('Petal L', style: headerStyle)),
        DataColumn(label: Text('Petal W', style: headerStyle)),
        DataColumn(label: Text('Class', style: headerStyle)),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('5.1')),
          DataCell(Text('3.5')),
          DataCell(Text('1.4')),
          DataCell(Text('0.2')),
          DataCell(Text('Setosa')),
        ]),
        DataRow(cells: [
          DataCell(Text('4.9')),
          DataCell(Text('3.0')),
          DataCell(Text('1.4')),
          DataCell(Text('0.2')),
          DataCell(Text('Setosa')),
        ]),
        DataRow(cells: [
          DataCell(Text('6.4')),
          DataCell(Text('3.2')),
          DataCell(Text('4.5')),
          DataCell(Text('1.5')),
          DataCell(Text('Versicolor')),
        ]),
        DataRow(cells: [
          DataCell(Text('6.3')),
          DataCell(Text('3.3')),
          DataCell(Text('6.0')),
          DataCell(Text('2.5')),
          DataCell(Text('Virginica')),
        ]),
      ],
    ),
  );
}
Widget datasetSampleValues(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Card(
    margin: const EdgeInsets.only(bottom: 20),
    elevation: 0,
    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      ),
    ),
    child: ExpansionTile(
      title: const Text(
        'Sample Data (Iris Dataset)',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text(
        'First few rows used for visualization',
        style: TextStyle(fontSize: 13),
      ),
      childrenPadding: const EdgeInsets.all(12),
      children: [
        _datasetTable(context),
      ],
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Model')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          datasetInfoCard(context),
          datasetSampleValues(context),

          sectionTitle('Regression'),
          modelTile(context, 'Linear Regression', 'Predict continuous values'),
          modelTile(context, 'Ridge Regression', 'Regularized regression'),
          modelTile(context, 'Lasso Regression', 'Feature selection'),
          comparisonTile(context, 'Compare Regression Models', 'regression'),

          sectionTitle('Classification'),
          modelTile(context, 'Logistic Regression', 'Binary classification'),
          modelTile(context, 'k-NN', 'Distance based classification'),
          modelTile(context, 'SVM', 'Maximum margin classifier'),
          modelTile(context, 'Naive Bayes', 'Probabilistic classifier'),
          comparisonTile(context, 'Compare Classification Models', 'classification'),

          sectionTitle('Tree-Based'),
          modelTile(context, 'Decision Tree (ID3)', 'Information Gain based tree'),
          modelTile(context, 'Decision Tree (CART)', 'Gini Index based tree'),
          modelTile(context, 'Random Forest', 'Ensemble of trees'),
          comparisonTile(context, 'Compare Tree Models', 'trees'),
        ],
      ),
    );
  }
}
