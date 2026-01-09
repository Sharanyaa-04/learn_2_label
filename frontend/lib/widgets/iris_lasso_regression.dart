import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IrisLassoRegression extends StatelessWidget {
  const IrisLassoRegression({super.key});

  @override
  Widget build(BuildContext context) {
    // Coefficients learned from Iris-like data
    final coefficients = [
      0.9, // sepal_length
      0.0, // sepal_width (eliminated)
      0.6, // petal_length
      0.0, // petal_width (eliminated)
    ];

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 1,

        titlesData: const FlTitlesData(show: true),
        gridData: const FlGridData(show: true),

        barGroups: List.generate(
          coefficients.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: coefficients[i],
                color: coefficients[i] == 0
                    ? Colors.grey
                    : Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
