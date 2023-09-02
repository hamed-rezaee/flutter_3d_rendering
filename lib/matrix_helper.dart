import 'dart:math';

import 'package:flutter_3d_rendering/vector.dart';

Vector multiplyMatrix(List<List<double>> matrix, Vector vector) {
  final List<double> vectorList = vector.toList();

  final List<double> result = [];

  for (int i = 0; i < matrix.length; i++) {
    double sum = 0;

    for (int j = 0; j < matrix[i].length; j++) {
      sum += matrix[i][j] * vectorList[j];
    }

    result.add(sum);
  }

  return Vector(result[0], result[1], result[2]);
}

List<List<double>> getProjectionMatrix() => [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 0]
    ];

List<List<double>> getRotatioX(double angle) => [
      [1, 0, 0],
      [0, cos(angle), -sin(angle)],
      [0, sin(angle), cos(angle)],
    ];

List<List<double>> getRotatioY(double angle) => [
      [cos(angle), 0, -sin(angle)],
      [0, 1, 0],
      [sin(angle), 0, cos(angle)],
    ];

List<List<double>> getRotatioZ(double angle) => [
      [cos(angle), -sin(angle), 0],
      [sin(angle), cos(angle), 0],
      [0, 0, 1],
    ];
