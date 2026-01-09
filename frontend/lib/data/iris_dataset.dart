
class IrisData {
  final double petalLength;
  final double petalWidth;
  final int label;
  // 0 = Setosa, 1 = Versicolor, 2 = Virginica

  IrisData(this.petalLength, this.petalWidth, this.label);
}

final List<IrisData> irisDataset = [
  // ---------- Setosa (0) ----------
  IrisData(1.4, 0.2, 0),
  IrisData(1.5, 0.2, 0),
  IrisData(1.3, 0.2, 0),
  IrisData(1.6, 0.4, 0),
  IrisData(1.5, 0.3, 0),
  IrisData(1.4, 0.3, 0),
  IrisData(1.7, 0.4, 0),
  IrisData(1.6, 0.2, 0),
  IrisData(1.5, 0.1, 0),
  IrisData(1.4, 0.2, 0),

  // ---------- Versicolor (1) ----------
  IrisData(4.7, 1.4, 1),
  IrisData(4.5, 1.5, 1),
  IrisData(4.9, 1.5, 1),
  IrisData(4.6, 1.3, 1),
  IrisData(4.4, 1.4, 1),
  IrisData(4.8, 1.6, 1),
  IrisData(4.7, 1.5, 1),
  IrisData(4.5, 1.3, 1),
  IrisData(4.6, 1.5, 1),
  IrisData(4.9, 1.6, 1),

  // ---------- Virginica (2) ----------
  IrisData(5.1, 1.8, 2),
  IrisData(5.9, 2.1, 2),
  IrisData(5.6, 2.2, 2),
  IrisData(6.1, 2.3, 2),
  IrisData(5.8, 2.2, 2),
  IrisData(6.0, 2.5, 2),
  IrisData(5.6, 2.4, 2),
  IrisData(5.9, 2.3, 2),
  IrisData(6.1, 2.4, 2),
  IrisData(5.8, 2.3, 2),
];

