import 'dart:math';

import 'package:flutter_3d_rendering/vector.dart';

Vector multiplyMatrix(List<List<double>> matrix, Vector vector) {
  final List<double> vectorList = vector.toList();

  final List<double> result = <double>[];

  for (int i = 0; i < matrix.length; i++) {
    double sum = 0;

    for (int j = 0; j < matrix[i].length; j++) {
      sum += matrix[i][j] * vectorList[j];
    }

    result.add(sum);
  }

  return Vector(result[0], result[1], result[2]);
}

List<List<double>> getProjectionMatrix([double z = 1]) => <List<double>>[
      <double>[z, 0, 0],
      <double>[0, z, 0],
      <double>[0, 0, 0]
    ];

List<List<double>> getRotatioX(double angle) => <List<double>>[
      <double>[1, 0, 0],
      <double>[0, cos(angle), -sin(angle)],
      <double>[0, sin(angle), cos(angle)],
    ];

List<List<double>> getRotatioY(double angle) => <List<double>>[
      <double>[cos(angle), 0, -sin(angle)],
      <double>[0, 1, 0],
      <double>[sin(angle), 0, cos(angle)],
    ];

List<List<double>> getRotatioZ(double angle) => <List<double>>[
      <double>[cos(angle), -sin(angle), 0],
      <double>[sin(angle), cos(angle), 0],
      <double>[0, 0, 1],
    ];
