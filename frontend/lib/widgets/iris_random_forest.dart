// import 'package:flutter/material.dart';

// class IrisRandomForest extends StatelessWidget {
//   const IrisRandomForest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Random Forest (Ensemble of Trees)',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: const [
//               _TreeCard(
//                 title: 'Tree 1',
//                 rule: 'petal_length < 2.4',
//                 prediction: 'Setosa',
//                 color: Colors.blue,
//               ),
//               _TreeCard(
//                 title: 'Tree 2',
//                 rule: 'petal_width < 1.7',
//                 prediction: 'Versicolor',
//                 color: Colors.orange,
//               ),
//               _TreeCard(
//                 title: 'Tree 3',
//                 rule: 'petal_length < 5.0',
//                 prediction: 'Virginica',
//                 color: Colors.purple,
//               ),
//             ],
//           ),

//           const SizedBox(height: 30),

//           const Icon(Icons.arrow_downward, size: 30),
//           const SizedBox(height: 10),

//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.green.shade100,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Text(
//               'Final Prediction (Majority Vote):  Versicolor',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TreeCard extends StatelessWidget {
//   final String title;
//   final String rule;
//   final String prediction;
//   final Color color;

//   const _TreeCard({
//     required this.title,
//     required this.rule,
//     required this.prediction,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color, width: 2),
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             rule,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 12),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             prediction,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class IrisRandomForest extends StatelessWidget {
  const IrisRandomForest({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: constraints.maxWidth,
        child: Center(
          child: CustomPaint(
            size: const Size(900, 500),
            painter: _ForestPainter(),
          ),
        ),
      ),
    );
  },
);

  }
}

class _ForestPainter extends CustomPainter {
  final Paint linePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2;

  final TextStyle textStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  void drawLine(Canvas c, Offset a, Offset b) {
    c.drawLine(a, b, linePaint);
  }

  void drawBox(
    Canvas c,
    Offset center,
    String text,
    Color color, {
    double w = 140,
    double h = 40,
  }) {
    final rect = Rect.fromCenter(center: center, width: w, height: h);
    final rrect =
        RRect.fromRectAndRadius(rect, const Radius.circular(10));

    c.drawRRect(rrect, Paint()..color = color.withOpacity(0.25));
    c.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final tp = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: w - 10);

    tp.paint(
      c,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  // Mini tree = root + two leaves
  void drawMiniTree(
    Canvas c,
    Offset root,
    String rule,
    String left,
    String right,
    Color leftColor,
    Color rightColor,
  ) {
    final leftLeaf = Offset(root.dx - 70, root.dy + 80);
    final rightLeaf = Offset(root.dx + 70, root.dy + 80);

    drawLine(c, root, leftLeaf);
    drawLine(c, root, rightLeaf);

    drawBox(c, root, rule, Colors.green);
    drawBox(c, leftLeaf, left, leftColor, w: 120);
    drawBox(c, rightLeaf, right, rightColor, w: 120);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // ---------------- Dataset ----------------
    final dataset = Offset(size.width / 2, 40);
    drawBox(canvas, dataset, 'Iris Dataset', Colors.grey, w: 180);

    // ---------------- Tree roots (spread wide) ----------------
    final t1 = Offset(size.width / 6, 140);
    final t2 = Offset(size.width / 2, 140);
    final t3 = Offset(5 * size.width / 6, 140);

    drawLine(canvas, dataset, t1);
    drawLine(canvas, dataset, t2);
    drawLine(canvas, dataset, t3);

    // ---------------- Trees ----------------
    drawMiniTree(
      canvas,
      t1,
      'petal_length < 2.5',
      'Setosa',
      'Versicolor',
      Colors.blue,
      Colors.orange,
    );

    drawMiniTree(
      canvas,
      t2,
      'petal_width < 1.75',
      'Versicolor',
      'Virginica',
      Colors.orange,
      Colors.purple,
    );

    drawMiniTree(
      canvas,
      t3,
      'petal_length < 4.8',
      'Versicolor',
      'Virginica',
      Colors.orange,
      Colors.purple,
    );

    // ---------------- Results ----------------
    final r1 = Offset(t1.dx, 300);
    final r2 = Offset(t2.dx, 300);
    final r3 = Offset(t3.dx, 300);

    drawLine(canvas, Offset(t1.dx, t1.dy + 80), r1);
    drawLine(canvas, Offset(t2.dx, t2.dy + 80), r2);
    drawLine(canvas, Offset(t3.dx, t3.dy + 80), r3);

    drawBox(canvas, r1, 'Result: Setosa', Colors.blue);
    drawBox(canvas, r2, 'Result: Versicolor', Colors.orange);
    drawBox(canvas, r3, 'Result: Versicolor', Colors.orange);

    // ---------------- Voting ----------------
    final voting = Offset(size.width / 2, 380);
    drawLine(canvas, r1, voting);
    drawLine(canvas, r2, voting);
    drawLine(canvas, r3, voting);

    drawBox(canvas, voting, 'Majority Voting', Colors.green, w: 200);

    // ---------------- Final ----------------
    final finalResult = Offset(size.width / 2, 450);
    drawLine(canvas, voting, finalResult);

    drawBox(
      canvas,
      finalResult,
      'Final Result: Versicolor',
      Colors.red,
      w: 220,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
