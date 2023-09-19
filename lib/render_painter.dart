import 'package:flutter/material.dart';
import 'package:flutter_3d_rendering/matrix_helper.dart';
import 'package:flutter_3d_rendering/vector.dart';

class RenderPainter extends CustomPainter {
  RenderPainter({
    required this.angle,
    required this.points,
  });

  final double angle;
  final List<Vector> points;

  final double poinSize = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;

    canvas.translate(size.width / 2, size.height / 2);

    _drawCube(canvas, paint);
  }

  void _drawCube(Canvas canvas, Paint paint) {
    final List<Vector> projectedPoints = <Vector>[];

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

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
