// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import '../data/iris_dataset.dart';

// // class IrisLogisticRegression extends StatelessWidget {
// //   const IrisLogisticRegression({super.key});

// //   double sigmoid(double x) => 1 / (1 + exp(-x));

// //   @override
// //   Widget build(BuildContext context) {
// //     final dataPoints = irisDataset.map((d) {
// //       return FlSpot(
// //         d.petalLength,
// //         d.label == 0 ? 0 : 1,
// //       );
// //     }).toList();

// //     final curve = List.generate(
// //       50,
// //       (i) {
// //         final x = i * 0.15;
// //         return FlSpot(x, sigmoid(x - 4));
// //       },
// //     );

// //     return LineChart(
// //       LineChartData(
// //         lineBarsData: [
// //           LineChartBarData(
// //             spots: dataPoints,
// //             barWidth: 0,
// //             dotData: const FlDotData(show: true),
// //           ),
// //           LineChartBarData(
// //             spots: curve,
// //             color: Colors.green,
// //             dotData: const FlDotData(show: false),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../data/iris_dataset.dart';

// class IrisLogisticRegression extends StatelessWidget {
//   const IrisLogisticRegression({super.key});

//   double sigmoid(double x) => 1 / (1 + exp(-x));

//   @override
//   Widget build(BuildContext context) {
//     // Binary: Setosa vs Non-Setosa
//     final points = irisDataset.map((d) {
//       return FlSpot(
//         d.petalLength,
//         d.label == 0 ? 0 : 1,
//       );
//     }).toList();

//     final curve = List.generate(
//       60,
//       (i) {
//         final x = i * 0.12;
//         return FlSpot(x, sigmoid(x - 4));
//       },
//     );

//     // Threshold line y = 0.5
//     final threshold = [
//       const FlSpot(0, 0.5),
//       const FlSpot(8, 0.5),
//     ];

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           minY: 0,
//           maxY: 1,
//           gridData: const FlGridData(show: true),
//           borderData: FlBorderData(show: true),
//           titlesData: const FlTitlesData(show: true),
//           lineBarsData: [
//             // Data points
//             LineChartBarData(
//               spots: points,
//               barWidth: 0,
//               dotData: const FlDotData(show: true),
//             ),
//             // Sigmoid curve
//             LineChartBarData(
//               spots: curve,
//               color: Colors.green,
//               barWidth: 2,
//               dotData: const FlDotData(show: false),
//             ),
//             // Threshold line
//             LineChartBarData(
//               spots: threshold,
//               color: Colors.red,
//               barWidth: 1,
//               dashArray: [5, 5],
//               dotData: const FlDotData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/iris_dataset.dart';

class IrisLogisticRegression extends StatelessWidget {
  const IrisLogisticRegression({super.key});

  double sigmoid(double x) => 1 / (1 + exp(-x));

  @override
  Widget build(BuildContext context) {
    // Binary classification: Setosa vs Non-Setosa
    final dataPoints = irisDataset.map((d) {
      return FlSpot(
        d.petalLength,
        d.label == 0 ? 0 : 1,
      );
    }).toList();

    // Determine x-range from actual data
    final minX = irisDataset
        .map((d) => d.petalLength)
        .reduce((a, b) => a < b ? a : b);
    final maxX = irisDataset
        .map((d) => d.petalLength)
        .reduce((a, b) => a > b ? a : b);

    // Generate smooth sigmoid curve
    final sigmoidCurve = List.generate(
      200,
      (i) {
        final x = minX + (i / 199) * (maxX - minX);
        final y = sigmoid(x - 4.5); // shift controls curve center
        return FlSpot(x, y);
      },
    );

    // Threshold line y = 0.5
    final thresholdLine = [
      FlSpot(minX, 0.5),
      FlSpot(maxX, 0.5),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0,
          maxY: 1,
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: true),
          lineBarsData: [
            // Data points (classes)
            LineChartBarData(
              spots: dataPoints,
              barWidth: 0,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) =>
                    FlDotCirclePainter(
                      radius: 3,
                      color: spot.y == 0
                          ? Colors.blue
                          : Colors.orange,
                    ),
              ),
            ),

            // S-curve (sigmoid)
            LineChartBarData(
              spots: sigmoidCurve,
              isCurved: true,
              color: Colors.green,
              barWidth: 3, // 👈 make it obvious
              dotData: const FlDotData(show: false),
            ),

            // Threshold line
            LineChartBarData(
              spots: thresholdLine,
              color: Colors.red,
              barWidth: 2,
              dashArray: [6, 4],
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
