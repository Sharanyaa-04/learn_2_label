import 'package:flutter/material.dart';

class PracticeProblemsScreen extends StatelessWidget {
  const PracticeProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How do I build?'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PracticeProblemCard(
            title: 'House Price Prediction',
            description:
                'You are given a dataset containing features such as house area, '
                'number of bedrooms, age of the house, distance to city center, '
                'and location type.',
            tasks: [
              'Understand the dataset and identify input features and target variable.',
              'Handle categorical variables appropriately.',
              'Split the data into training and testing sets.',
              'Select a suitable algorithm.',
              'Evaluate the model using appropriate metrics.',
            ],
          ),

          PracticeProblemCard(
            title: 'Flower Classification',
            description:
                'A dataset contains measurements of flowers such as petal length, '
                'petal width, sepal length, and sepal width.',
            tasks: [
              'Analyze the dataset and identify the target class.',
              'Perform feature scaling if required.',
              'Choose a suitable algorithm.',
              'Train and test the model.',
              'Evaluate classification performance.',
            ],
          ),

          PracticeProblemCard(
            title: 'Loan Approval Prediction',
            description:
                'Given customer details such as income, credit score, employment '
                'status, and loan amount, determine whether a loan should be approved.',
            tasks: [
              'Identify relevant features and the target variable.',
              'Handle missing or inconsistent data.',
              'Choose an appropriate algorithm.',
              'Evaluate results using confusion matrix or accuracy.',
            ],
          ),

          PracticeProblemCard(
            title: 'Customer Decision Rules',
            description:
                'A dataset contains customer attributes and purchase behavior.',
            tasks: [
              'Analyze which features influence customer decisions.',
              'Construct a suitable model.',
              'Visualize the learned rules.',
              'Check for overfitting and refine the model.',
            ],
          ),
        ],
      ),
    );
  }
}

class PracticeProblemCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tasks;

  const PracticeProblemCard({
    super.key,
    required this.title,
    required this.description,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              description,
              style: const TextStyle(height: 1.5),
            ),

            const SizedBox(height: 12),

            const Text(
              'What to do:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            ...tasks.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  '),
                    Expanded(child: Text(task)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
