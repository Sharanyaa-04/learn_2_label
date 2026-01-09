import 'package:flutter/material.dart';

class MLBasicsScreen extends StatelessWidget {
  const MLBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Learning Basics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('What is Machine Learning?'),
            paragraph(
              'Machine Learning is a field of AI where systems learn patterns '
              'from data instead of being explicitly programmed.'
              'Machine Learning is a way for computers to learn from data instead of being programmed step by step.'
              'Just like humans learn from experience, machines learn by finding patterns in examples.'),
              paragraph(
              'For example:'
            ),
            bullet('If you show a system many emails labeled spam and not spam, it slowly learns how to tell the difference.'),
            bullet('If you give it past marks and study hours, it can learn to predict future scores.'),
            bullet('The more quality data it sees, the better it gets at making decisions or predictions.'),

            sectionTitle('Types of Machine Learning'),
            bullet('Supervised Learning: Learn from labeled data'),
            bullet('Unsupervised Learning: Discover patterns without labels'),
            bullet('Reinforcement Learning: Learn by interacting with an environment'),

            sectionTitle('Supervised vs Unsupervised Learning'),
            bullet('Supervised Learning : Uses labeled data, where each input is paired with a known output. The goal is to learn a mapping from inputs to outputs.'),
            bullet('Unsupervised Learning : Uses unlabeled data, where no explicit output is provided. The goal is to discover structure or patterns in the data.'),
            paragraph('Key difference :  Supervised learning learns from labeled examples; unsupervised learning does not.'),

            sectionTitle('Features and Labels'),
            bullet('Features are input variables used by a machine learning model to make predictions.'),
            bullet('Labels are the target values that the model is trained to predict.'),
            paragraph(
              'Core Idea : Features describe the data; labels represent the desired outcome.'
            ),

            sectionTitle('Training, Validation & Test Sets'),
            bullet('Training Set : Used to learn model parameters.'),
            bullet('Validation Set : Used to tune hyperparameters and select models.'),
            bullet('Test Set : Used only for final evaluation of model performance.'),
            paragraph(
              'Why this matters : Separating data helps measure how well a model generalizes to unseen data.',

            ),

            sectionTitle('Overfitting vs Underfitting'),
            paragraph(
              'Overfitting happens when a model memorizes data. '
              'Underfitting happens when a model is too simple to learn patterns.'
            ),

            sectionTitle('Bias–Variance Tradeoff'),
            bullet('Overfitting  occurs when a model learns noise instead of underlying patterns, resulting in low training error but high test error.'),  
            bullet('Underfitting occurs when a model is too simple to capture patterns, resulting in high error on both training and test data.'),
            paragraph(
              'Key difference :  Overfitting memorizes; underfitting oversimplifies.'
            ),

            sectionTitle('Data Cleaning'),
            bullet('Handling missing values'),
            bullet('Removing outliers'),
            bullet('Eliminating duplicates'),

            sectionTitle('Feature Engineering'),
            bullet('Scaling and normalization'),
            bullet('Encoding categorical variables'),
            bullet('Feature selection'),

            sectionTitle('Cross-Validation'),
            paragraph(
              'Cross-validation evaluates models on multiple data splits '
              'to ensure consistent performance.'
            ),

            sectionTitle('Data Distribution Concepts'),
            bullet('Skewed distributions'),
            bullet('Class imbalance'),
            bullet('Correlation between features'),

            sectionTitle('Training Flow'),
            paragraph(
              'Data → Cleaning → Feature Engineering → Model Training → '
              'Validation → Testing → Deployment'
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget paragraph(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15),
    );
  }

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
