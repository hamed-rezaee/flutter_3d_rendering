import 'package:flutter/material.dart';
import 'package:flutter_3d_rendering/matrix_helper.dart';
import 'package:flutter_3d_rendering/vector.dart';

class RenderPainter extends CustomPainter {
  RenderPainter({
    required this.angle,
    required this.points,
    required this.projectionMatrix,
  });

  final double angle;
  final List<Vector> points;
  final List<List<double>> projectionMatrix;

  final double poinSize = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;

    canvas.translate(size.width / 2, size.height / 2);

    for (final Vector point in points) {
      Vector projected2dPoint = multiplyMatrix(projectionMatrix, point);

      canvas.drawCircle(projected2dPoint.toOffset(), poinSize, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
