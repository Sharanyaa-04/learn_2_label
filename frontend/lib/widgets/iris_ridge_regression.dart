import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IrisRidgeRegression extends StatelessWidget {
  const IrisRidgeRegression({super.key});

  @override
  Widget build(BuildContext context) {
    // Iris samples: sepal_length vs petal_length
    final points = [
      const FlSpot(4.9, 1.4),
      const FlSpot(5.4, 1.7),
      const FlSpot(5.8, 4.0),
      const FlSpot(6.0, 4.5),
      const FlSpot(6.7, 5.6),
    ];

    // Ordinary Linear Regression
    final linearLine = [
      const FlSpot(4.8, 1.2),
      const FlSpot(6.8, 5.8),
    ];

    // Ridge Regression (shrunk slope)
    final ridgeLine = [
      const FlSpot(4.8, 1.8),
      const FlSpot(6.8, 5.0),
    ];

    return LineChart(
      LineChartData(
        minX: 4.5,
        maxX: 7,
        minY: 1,
        maxY: 6,

        titlesData: const FlTitlesData(show: true),
        gridData: const FlGridData(show: true),

        lineBarsData: [
          // Iris points
          LineChartBarData(
            spots: points,
            barWidth: 0,
            dotData: const FlDotData(show: true),
          ),

          // Linear
          LineChartBarData(
            spots: linearLine,
            color: Colors.blue,
            barWidth: 2,
          ),

          // Ridge
          LineChartBarData(
            spots: ridgeLine,
            color: Colors.red,
            barWidth: 2,
          ),
        ],
      ),
    );
  }
}
