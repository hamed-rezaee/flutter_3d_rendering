import 'package:flutter/material.dart';

import 'package:flutter_3d_rendering/matrix_helper.dart';
import 'package:flutter_3d_rendering/vector.dart';

class CubeRenderer {
  CubeRenderer(this.angle);

  final double angle;

  void render(Canvas canvas, Paint paint) {
    final List<Vector> projectedPoints = <Vector>[];
    final List<Vector> points = <Vector>[
      Vector(1, 1, 1),
      Vector(-1, 1, 1),
      Vector(-1, -1, 1),
      Vector(1, -1, 1),
      Vector(1, 1, -1),
      Vector(-1, 1, -1),
      Vector(-1, -1, -1),
      Vector(1, -1, -1),
    ];

    for (int i = 0; i < points.length; i++) {
      Vector rotatedPoint = multiplyMatrix(getRotatioY(angle), points[i]);
      rotatedPoint = multiplyMatrix(getRotatioX(angle), rotatedPoint);
      rotatedPoint = multiplyMatrix(getRotatioZ(angle), rotatedPoint);

      final double z = 1 / (4 - rotatedPoint.z);

      final Vector projectedPoint =
          multiplyMatrix(getProjectionMatrix(z), rotatedPoint) * 300;

      projectedPoints.add(projectedPoint);
    }

    for (int i = 0; i < 4; i++) {
      _connect(canvas, i, (i + 1) % 4, projectedPoints, paint);
      _connect(canvas, i + 4, ((i + 1) % 4) + 4, projectedPoints, paint);
      _connect(canvas, i, i + 4, projectedPoints, paint);
    }
  }

  void _connect(
    Canvas canvas,
    int i,
    int j,
    List<Vector> points,
    Paint paint,
  ) =>
      canvas.drawLine(points[i].toOffset(), points[j].toOffset(), paint);
}
