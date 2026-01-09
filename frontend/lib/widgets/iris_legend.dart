import 'package:flutter/material.dart';
import '../utils/iris_colors.dart';

class IrisLegend extends StatelessWidget {
  const IrisLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _LegendItem('Setosa'),
        SizedBox(width: 12),
        _LegendItem('Versicolor'),
        SizedBox(width: 12),
        _LegendItem('Virginica'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  const _LegendItem(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 10, color: irisColor(label)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
