import 'package:flutter_3d_rendering/vector.dart';

Vector multiplyMatrix(List<List<double>> matrix, Vector vector) {
  final List<double> vectorList = vector.toList();

  final List<double> result = List<double>.filled(matrix.length, 0);

  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < vectorList.length; j++) {
      result[i] += matrix[i][j] * vectorList[j];
    }
  }

  return Vector(result[0], result[1], 0);
}
