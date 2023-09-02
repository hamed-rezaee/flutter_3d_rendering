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

  final double poinSize = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;

    canvas.translate(size.width / 2, size.height / 2);

    List<Vector> projectedPoints = [];

    for (int i = 0; i < points.length; i++) {
      Vector rotatedPoint = multiplyMatrix(getRotatioY(angle), points[i]);
      rotatedPoint = multiplyMatrix(getRotatioX(angle), rotatedPoint);
      rotatedPoint = multiplyMatrix(getRotatioZ(angle), rotatedPoint);

      final Vector projectedPoint =
          multiplyMatrix(getProjectionMatrix(), rotatedPoint) * 150;

      projectedPoints.add(projectedPoint);
    }

    for (int i = 0; i < 4; i++) {
      _connect(canvas, i, (i + 1) % 4, projectedPoints, paint);
      _connect(canvas, i + 4, ((i + 1) % 4) + 4, projectedPoints, paint);
      _connect(canvas, i, i + 4, projectedPoints, paint);
    }

    for (int i = 0; i < projectedPoints.length; i++) {
      canvas.drawCircle(projectedPoints[i].toOffset(), poinSize, paint);
    }
  }

  void _connect(
    Canvas canvas,
    int i,
    int j,
    List<Vector> points,
    Paint paint,
  ) =>
      canvas.drawLine(
        points[i].toOffset(),
        points[j].toOffset(),
        paint,
      );

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
