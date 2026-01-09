
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../data/iris_dataset.dart';

// class IrisLinearRegression extends StatefulWidget {
//   const IrisLinearRegression({super.key});

//   @override
//   State<IrisLinearRegression> createState() => _IrisLinearRegressionState();
// }

// class _IrisLinearRegressionState extends State<IrisLinearRegression> {
//   double m = 0.5;
//   double c = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     final points = irisDataset
//         .map((d) => FlSpot(d.petalLength, d.petalWidth))
//         .toList();

//     final line = points
//         .map((p) => FlSpot(p.x, m * p.x + c))
//         .toList();

//     return Column(
//       children: [
//         Expanded(
//           child: LineChart(
//             LineChartData(
//               lineBarsData: [
//                 // Data points
//                 LineChartBarData(
//                   spots: points,
//                   barWidth: 0,
//                   dotData: const FlDotData(show: true),
//                 ),
//                 // Regression line
//                 LineChartBarData(
//                   spots: line,
//                   color: Colors.red,
//                   barWidth: 2,
//                   dotData: const FlDotData(show: false),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Slider(
//           value: m,
//           min: -1,
//           max: 1,
//           label: "m = ${m.toStringAsFixed(2)}",
//           onChanged: (v) => setState(() => m = v),
//         ),
//         Slider(
//           value: c,
//           min: -2,
//           max: 2,
//           label: "c = ${c.toStringAsFixed(2)}",
//           onChanged: (v) => setState(() => c = v),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../data/iris_dataset.dart';

// class IrisLinearRegression extends StatelessWidget {
//   const IrisLinearRegression({super.key});

//   // Fixed default values
//   final double m = 0.6;
//   final double c = 0.2;

//   @override
//   Widget build(BuildContext context) {
//     final points = irisDataset
//         .map((d) => FlSpot(d.petalLength, d.petalWidth))
//         .toList();

//     final line = points
//         .map((p) => FlSpot(p.x, m * p.x + c))
//         .toList();

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: const FlGridData(show: true),
//           borderData: FlBorderData(show: true),
//           titlesData: const FlTitlesData(show: true),
//           lineBarsData: [
//             // Data points only
//             LineChartBarData(
//               spots: points,
//               barWidth: 0,
//               dotData: const FlDotData(show: true),
//             ),
//             // Regression line
//             LineChartBarData(
//               spots: line,
//               color: Colors.red,
//               barWidth: 2,
//               dotData: const FlDotData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../data/iris_dataset.dart';

// class IrisLinearRegression extends StatelessWidget {
//   const IrisLinearRegression({super.key});

//   // ---- Least Squares Calculation ----
//   double _calculateSlope(List<double> x, List<double> y) {
//     final n = x.length;
//     final xMean = x.reduce((a, b) => a + b) / n;
//     final yMean = y.reduce((a, b) => a + b) / n;

//     double numerator = 0;
//     double denominator = 0;

//     for (int i = 0; i < n; i++) {
//       numerator += (x[i] - xMean) * (y[i] - yMean);
//       denominator += (x[i] - xMean) * (x[i] - xMean);
//     }

//     return numerator / denominator;
//   }

//   double _calculateIntercept(double xMean, double yMean, double m) {
//     return yMean - m * xMean;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final x = irisDataset.map((d) => d.petalLength).toList();
//     final y = irisDataset.map((d) => d.petalWidth).toList();

//     final m = _calculateSlope(x, y);
//     final c = _calculateIntercept(
//       x.reduce((a, b) => a + b) / x.length,
//       y.reduce((a, b) => a + b) / y.length,
//       m,
//     );

//     final points = List.generate(
//       x.length,
//       (i) => FlSpot(x[i], y[i]),
//     );

//     final minX = x.reduce((a, b) => a < b ? a : b);
//     final maxX = x.reduce((a, b) => a > b ? a : b);

//     final regressionLine = [
//       FlSpot(minX, m * minX + c),
//       FlSpot(maxX, m * maxX + c),
//     ];

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
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
//             // Correct regression line
//             LineChartBarData(
//   spots: points,
//   barWidth: 0,
//   dotData: FlDotData(
//     show: true,
//     getDotPainter: (spot, percent, bar, index) =>
//         FlDotCirclePainter(
//           radius: 4,
//           color: Colors.blue,
//         ),
//   ),
// ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/iris_dataset.dart';

class IrisLinearRegression extends StatelessWidget {
  const IrisLinearRegression({super.key});

  double _calculateSlope(List<double> x, List<double> y) {
    final n = x.length;
    final xMean = x.reduce((a, b) => a + b) / n;
    final yMean = y.reduce((a, b) => a + b) / n;

    double num = 0;
    double den = 0;

    for (int i = 0; i < n; i++) {
      num += (x[i] - xMean) * (y[i] - yMean);
      den += (x[i] - xMean) * (x[i] - xMean);
    }
    return num / den;
  }

  double _calculateIntercept(double xMean, double yMean, double m) {
    return yMean - m * xMean;
  }

  @override
  Widget build(BuildContext context) {
    final x = irisDataset.map((d) => d.petalLength).toList();
    final y = irisDataset.map((d) => d.petalWidth).toList();

    final m = _calculateSlope(x, y);
    final c = _calculateIntercept(
      x.reduce((a, b) => a + b) / x.length,
      y.reduce((a, b) => a + b) / y.length,
      m,
    );

    final points = List.generate(
      x.length,
      (i) => FlSpot(x[i], y[i]),
    );

    // 🔴 Draw MANY points for the line
    final minX = x.reduce((a, b) => a < b ? a : b);
    final maxX = x.reduce((a, b) => a > b ? a : b);

    final regressionLine = List.generate(
      100,
      (i) {
        final xi = minX + (i / 99) * (maxX - minX);
        return FlSpot(xi, m * xi + c);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          minX: minX - 0.2,
          maxX: maxX + 0.2,
          minY: 0,
          maxY: 3,
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: true),
          lineBarsData: [
            // Data points
            LineChartBarData(
              spots: points,
              barWidth: 0,
              dotData: FlDotData(
                show: true,
                getDotPainter: (_, __, ___, ____) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
                    ),
              ),
            ),

            // Regression line (NOW CLEAR)
            LineChartBarData(
              spots: regressionLine,
              isCurved: false,
              color: Colors.red,
              barWidth: 3, // 👈 thicker
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
