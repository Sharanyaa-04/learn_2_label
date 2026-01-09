import 'package:flutter/material.dart';

Color irisColor(String cls) {
  switch (cls) {
    case 'Setosa':
      return Colors.blue;
    case 'Versicolor':
      return Colors.orange;
    case 'Virginica':
      return Colors.purple;
    default:
      return Colors.grey;
  }
}
