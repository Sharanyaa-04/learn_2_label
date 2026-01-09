// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../data/iris_dataset.dart';

// class IrisKNN extends StatelessWidget {
//   const IrisKNN({super.key});

//   Color classColor(int label) {
//     switch (label) {
//       case 0:
//         return Colors.blue;      // Setosa
//       case 1:
//         return Colors.orange;    // Versicolor
//       default:
//         return Colors.purple;    // Virginica
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<ScatterSpot> spots = irisDataset.map((d) {
//       return ScatterSpot(
//         d.petalLength,
//         d.petalWidth,
//         dotPainter: FlDotCirclePainter(
//           radius: 6,
//           color: classColor(d.label),
//         ),
//       );
//     }).toList();

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ScatterChart(
//         ScatterChartData(
//           scatterSpots: spots,
//           gridData: const FlGridData(show: true),
//           borderData: FlBorderData(show: true),
//           titlesData: const FlTitlesData(show: true),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/iris_dataset.dart';
import 'dart:math';

class IrisKNN extends StatefulWidget {
  const IrisKNN({super.key});

  @override
  State<IrisKNN> createState() => _IrisKNNState();
}

class _IrisKNNState extends State<IrisKNN> {
  ScatterSpot? userPoint;

  Color classColor(int label) {
    switch (label) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  int classify(double x, double y) {
    // 1-NN for simplicity
    double minDist = double.infinity;
    int predictedLabel = 0;

    for (var d in irisDataset) {
      final dist = sqrt(
        pow(d.petalLength - x, 2) +
        pow(d.petalWidth - y, 2),
      );

      if (dist < minDist) {
        minDist = dist;
        predictedLabel = d.label;
      }
    }
    return predictedLabel;
  }

  @override
  Widget build(BuildContext context) {
    final spots = irisDataset.map((d) {
      return ScatterSpot(
        d.petalLength,
        d.petalWidth,
        dotPainter: FlDotCirclePainter(
          radius: 6,
          color: classColor(d.label),
        ),
      );
    }).toList();

    if (userPoint != null) {
      spots.add(userPoint!);
    }

    return GestureDetector(
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox;
        final local = box.globalToLocal(details.globalPosition);

        // Map tap to data space (simple approximation)
        final x = (local.dx / box.size.width) * 7;
        final y = (1 - local.dy / box.size.height) * 3;

        final label = classify(x, y);

        setState(() {
          userPoint = ScatterSpot(
            x,
            y,
            dotPainter: FlDotCirclePainter(
              radius: 8,
              color: classColor(label),
            ),
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ScatterChart(
          ScatterChartData(
            minX: 0,
            maxX: 7,
            minY: 0,
            maxY: 3,
            gridData: const FlGridData(show: true),
            borderData: FlBorderData(show: true),
            titlesData: const FlTitlesData(show: true),
            scatterSpots: spots,
          ),
        ),
      ),
    );
  }
}
