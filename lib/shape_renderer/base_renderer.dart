import 'package:flutter/material.dart';
import 'package:flutter_3d_rendering/vector.dart';

abstract class BaseRenderer {
  BaseRenderer({this.angleX = 0, this.angleY = 0, this.angleZ = 0});

  final double angleX;
  final double angleY;
  final double angleZ;

  void render(Canvas canvas, Paint paint);

  void connect(Canvas canvas, int i, int j, List<Vector> points, Paint paint) =>
      canvas.drawLine(points[i].toOffset(), points[j].toOffset(), paint);
}
