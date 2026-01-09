import 'package:flutter/material.dart';

class DecisionTreeDiagram extends StatelessWidget {
  const DecisionTreeDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(350, 450),
        painter: _DecisionTreePainter(),
      ),
    );
  }
}
class _DecisionTreePainter extends CustomPainter {
  final Paint linePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2;

  final Paint nodePaint = Paint()
    ..color = Colors.green.shade100;

  final TextStyle textStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  void drawNode(
    Canvas canvas,
    Offset center,
    String text,
    Size size,
  ) {
    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );

    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rrect, nodePaint);
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  void drawLine(Canvas canvas, Offset from, Offset to, String label) {
    canvas.drawLine(from, to, linePaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final mid = Offset(
      (from.dx + to.dx) / 2,
      (from.dy + to.dy) / 2,
    );

    textPainter.paint(canvas, mid);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Node positions
    final windy = Offset(size.width / 2, 40);

    final outlook = Offset(size.width / 4, 120);
    final temperature = Offset(3 * size.width / 4, 120);

    final humidity = Offset(size.width / 8, 220);
    final yes1 = Offset(size.width / 4, 220);
    final no1 = Offset(3 * size.width / 8, 220);

    final yes2 = Offset(5 * size.width / 8, 220);
    final no2 = Offset(7 * size.width / 8, 220);

    final leafYes1 = Offset(size.width / 16, 320);
    final leafNo1 = Offset(3 * size.width / 16, 320);

    // Lines
    drawLine(canvas, windy, outlook, 'True');
    drawLine(canvas, windy, temperature, 'False');

    drawLine(canvas, outlook, humidity, 'Sunny');
    drawLine(canvas, outlook, yes1, 'Overcast');
    drawLine(canvas, outlook, no1, 'Rainy');

    drawLine(canvas, humidity, leafYes1, '< 83');
    drawLine(canvas, humidity, leafNo1, '> 83');

    drawLine(canvas, temperature, yes2, '< 83');
    drawLine(canvas, temperature, no2, '> 83');

    // Nodes
    drawNode(canvas, windy, 'WINDY', const Size(90, 40));
    drawNode(canvas, outlook, 'OUTLOOK', const Size(100, 40));
    drawNode(canvas, temperature, 'TEMPERATURE', const Size(120, 40));

    drawNode(canvas, humidity, 'HUMIDITY', const Size(100, 40));

    drawNode(canvas, yes1, 'Yes', const Size(60, 35));
    drawNode(canvas, no1, 'No', const Size(60, 35));

    drawNode(canvas, yes2, 'Yes', const Size(60, 35));
    drawNode(canvas, no2, 'No', const Size(60, 35));

    drawNode(canvas, leafYes1, 'Yes', const Size(60, 35));
    drawNode(canvas, leafNo1, 'No', const Size(60, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
