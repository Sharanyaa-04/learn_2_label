import 'package:flutter/material.dart';

class IrisDecisionTree extends StatelessWidget {
  const IrisDecisionTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(420, 320), // more width
        painter: _IrisTreePainter(),
      ),
    );
  }
}

class _IrisTreePainter extends CustomPainter {
  final Paint linePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2;

  final TextStyle nodeText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  void drawNode(Canvas canvas, Offset c, String text, Color color) {
    const width = 160.0;
    const height = 42.0;

    final rect = Rect.fromCenter(center: c, width: width, height: height);
    final rrect =
        RRect.fromRectAndRadius(rect, const Radius.circular(12));

    canvas.drawRRect(
      rrect,
      Paint()..color = color.withOpacity(0.25),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final tp = TextPainter(
      text: TextSpan(text: text, style: nodeText),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - 12);

    tp.paint(
      canvas,
      Offset(
        c.dx - tp.width / 2,
        c.dy - tp.height / 2,
      ),
    );
  }

  void drawLine(Canvas canvas, Offset a, Offset b) {
    canvas.drawLine(a, b, linePaint);
  }

  void drawEdgeLabel(
    Canvas canvas,
    Offset position,
    String text,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(
      canvas,
      Offset(
        position.dx - tp.width / 2,
        position.dy - tp.height / 2,
      ),
    );
  }

  @override
  @override
void paint(Canvas canvas, Size size) {
  // -------- Node positions (correct spacing) --------

  final root = Offset(size.width / 2, 40);

  // Level 1
  final leftLeaf = Offset(size.width / 4, 160);
  final rightNode = Offset(3 * size.width / 4, 160);

  // Level 2 (RIGHT SUBTREE – PUSHED DOWN & WIDER)
  final rightLeftLeaf = Offset(3 * size.width / 4 - 140, 300);
  final rightRightLeaf = Offset(3 * size.width / 4 + 140, 300);

  // -------- Lines --------
  drawLine(canvas, root, leftLeaf);
  drawLine(canvas, root, rightNode);
  drawLine(canvas, rightNode, rightLeftLeaf);
  drawLine(canvas, rightNode, rightRightLeaf);

  // -------- Edge labels (clear & non-overlapping) --------
  drawEdgeLabel(
    canvas,
    Offset(root.dx - 70, root.dy + 50),
    'Yes',
  );
  drawEdgeLabel(
    canvas,
    Offset(root.dx + 70, root.dy + 50),
    'No',
  );

  drawEdgeLabel(
    canvas,
    Offset(rightNode.dx - 90, rightNode.dy + 55),
    '< 1.75',
  );
  drawEdgeLabel(
    canvas,
    Offset(rightNode.dx + 90, rightNode.dy + 55),
    '≥ 1.75',
  );

  // -------- Nodes --------
  drawNode(canvas, root, 'petal_length < 2.45', Colors.green);
  drawNode(canvas, leftLeaf, 'Setosa', Colors.blue);
  drawNode(canvas, rightNode, 'petal_width < 1.75', Colors.green);
  drawNode(canvas, rightLeftLeaf, 'Versicolor', Colors.orange);
  drawNode(canvas, rightRightLeaf, 'Virginica', Colors.purple);
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
