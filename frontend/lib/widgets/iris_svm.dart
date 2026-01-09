import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IrisSVM extends StatelessWidget {
  const IrisSVM({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ScatterChart(
        ScatterChartData(
          minX: 1,
          maxX: 5.5,
          minY: 0,
          maxY: 2,

          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: true),
          borderData: FlBorderData(show: true),

          scatterSpots: [
            // -------- Setosa --------
            ScatterSpot(
              1.4,
              0.2,
              dotPainter: FlDotCirclePainter(
                radius: 5,
                color: Colors.blue,
              ),
            ),
            ScatterSpot(
              1.5,
              0.3,
              dotPainter: FlDotCirclePainter(
                radius: 8, // SUPPORT VECTOR
                color: Colors.blue,
                strokeWidth: 2,
                strokeColor: Colors.black,
              ),
            ),
            ScatterSpot(
              1.3,
              0.2,
              dotPainter: FlDotCirclePainter(
                radius: 5,
                color: Colors.blue,
              ),
            ),

            // -------- Versicolor --------
            ScatterSpot(
              4.5,
              1.5,
              dotPainter: FlDotCirclePainter(
                radius: 8, // SUPPORT VECTOR
                color: Colors.orange,
                strokeWidth: 2,
                strokeColor: Colors.black,
              ),
            ),
            ScatterSpot(
              4.7,
              1.4,
              dotPainter: FlDotCirclePainter(
                radius: 5,
                color: Colors.orange,
              ),
            ),
            ScatterSpot(
              4.9,
              1.5,
              dotPainter: FlDotCirclePainter(
                radius: 5,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
