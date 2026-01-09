import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            title: const Text(
              'What is the difference between training error and test error?',
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              bulletPoint(
                'Training error is the error the model makes on data it has already seen.',
              ),
              bulletPoint(
                'Test error is the error on new, unseen data.',
              ),
              bulletPoint(
                'A good model has low training error and low test error.',
              ),
              bulletPoint(
                'If training error is low but test error is high, the model is likely overfitting.',
              ),
            ],
          ),

          ExpansionTile(
            title: const Text('Why do some models overfit even if training error is low?'),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: const [
              Text(
                'Because the model may be memorizing the training data instead of learning patterns.'
                 'Complex models can fit noise very well, which hurts performance on new data.',
                style: TextStyle(fontSize: 14.5, height: 1.5),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'How do you choose features and hyperparameters?',
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              bulletPoint(
                'Features are chosen based on domain knowledge, correlation with output, and experiments.',
              ),
              bulletPoint(
                'Hyperparameters are chosen using techniques like grid search, random search, or validation sets.',
              ),
              bulletPoint(
                'The goal is to balance accuracy and generalization.',
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'What is the difference between bias and variance?',
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              bulletPoint(
                'Bias: Error from overly simple assumptions (underfitting).',
              ),
              bulletPoint(
                'Variance: Error from too much sensitivity to data (overfitting).',
              ),
              bulletPoint(
                'A good model finds the right balance between both.',
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'Why do we normalize or scale features?',
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
  Align(
    alignment: Alignment.centerLeft,
    child: const Text(
      'Because features with large values can dominate learning. '
      'Scaling helps algorithms:',
      style: TextStyle(fontSize: 14.5, height: 1.5),
    ),
  ),
  bulletPoint('Converge faster'),
  bulletPoint('Treat all features fairly'),
  bulletPoint(
    'Perform better in distance-based and gradient-based models',
  ),
],

          ),
          ExpansionTile(
            title: const Text('How does cross-validation prevent overfitting?'),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: const [
              Text(
                'Cross-validation tests the model on multiple data splits instead of just one.'
                'This gives a more reliable estimate of performance and reduces dependence on a single train–test split.',
                style: TextStyle(fontSize: 14.5, height: 1.5),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'When is a parametric model better than a non-parametric model?',
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              bulletPoint(
                'Parametric models are better when data is limited and patterns are simple.',
              ),
              bulletPoint(
                'They are faster, easier to interpret, and less prone to overfitting..',
              ),
              bulletPoint(
                'A good model finds the right balance between both.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 🔹 Bullet widget
Widget bulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14.5, height: 1.5),
          ),
        ),
      ],
    ),
  );
}
