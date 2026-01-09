import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IrisNaiveBayes extends StatelessWidget {
  const IrisNaiveBayes({super.key});

  @override
  Widget build(BuildContext context) {
    // Probabilities for a Versicolor-like sample
    final probs = {
      'Setosa': 0.05,
      'Versicolor': 0.82,
      'Virginica': 0.13,
    };

    final colors = {
      'Setosa': Colors.blue,
      'Versicolor': Colors.orange,
      'Virginica': Colors.purple,
    };

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 1,

        titlesData: const FlTitlesData(show: true),
        gridData: const FlGridData(show: true),

        barGroups: probs.entries.mapIndexed((i, e) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: e.value,
                color: colors[e.key]!,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

extension MapIndex<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int, T) f) sync* {
    int i = 0;
    for (final e in this) {
      yield f(i++, e);
    }
  }
}
