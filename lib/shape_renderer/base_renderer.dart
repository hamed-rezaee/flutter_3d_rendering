import 'package:flutter/material.dart';
import 'package:flutter_3d_rendering/vector.dart';

abstract class BaseRenderer {
  BaseRenderer(this.angle);

  final double angle;

  void render(Canvas canvas, Paint paint);

  void connect(Canvas canvas, int i, int j, List<Vector> points, Paint paint) =>
      canvas.drawLine(points[i].toOffset(), points[j].toOffset(), paint);
}
