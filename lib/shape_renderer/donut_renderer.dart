import 'dart:math';
import 'dart:ui';

import 'package:flutter_3d_rendering/matrix_helper.dart';
import 'package:flutter_3d_rendering/shape_renderer/base_renderer.dart';
import 'package:flutter_3d_rendering/vector.dart';

class DonutRenderer extends BaseRenderer {
  DonutRenderer({
    super.angleX,
    super.angleY,
    super.angleZ,
    this.zoom = 300,
    this.majorRadius = 1,
    this.minorRadius = 0.5,
    this.majorSegmentsCount = 64,
    this.minorSegmentsCounts = 32,
    this.showPoints = false,
    this.showLines = true,
  });

  final double zoom;
  final double majorRadius;
  final double minorRadius;
  final int majorSegmentsCount;
  final int minorSegmentsCounts;
  final bool showPoints;
  final bool showLines;

  @override
  void render(Canvas canvas, Paint paint) {
    final List<Vector> projectedPoints = <Vector>[];

    for (int i = 0; i < majorSegmentsCount; i++) {
      final double majorAngle = _getAngle(i, majorSegmentsCount);

      for (int j = 0; j < minorSegmentsCounts; j++) {
        final double minorAngle = _getAngle(j, minorSegmentsCounts);

        final Vector point = Vector(
          _getXComponent(minorAngle, majorAngle),
          _getYComponent(minorAngle, majorAngle),
          _getZComponent(minorAngle),
        );

        Vector rotatedPoint = multiplyMatrix(getRotatioX(angleX), point);
        rotatedPoint = multiplyMatrix(getRotatioY(angleY), rotatedPoint);
        rotatedPoint = multiplyMatrix(getRotatioZ(angleZ), rotatedPoint);

        projectedPoints.add(_getProjectedPoint(rotatedPoint) * zoom);
      }
    }

    _connectPoints(canvas, projectedPoints, paint);
  }

  double _getAngle(int value, int segmentCount) =>
      (value / segmentCount) * 2 * pi;

  double _getXComponent(double minorAngle, double majorAngle) =>
      (majorRadius + minorRadius * cos(minorAngle)) * cos(majorAngle);

  double _getYComponent(double minorAngle, double majorAngle) =>
      (majorRadius + minorRadius * cos(minorAngle)) * sin(majorAngle);

  double _getZComponent(double minorAngle) => minorRadius * sin(minorAngle);

  Vector _getProjectedPoint(Vector rotatedPoint) => multiplyMatrix(
        getProjectionMatrix(1 / (3 - rotatedPoint.z)),
        rotatedPoint,
      );

  void _connectPoints(
    Canvas canvas,
    List<Vector> projectedPoints,
    Paint paint,
  ) {
    if (showPoints) {
      canvas.drawPoints(
        PointMode.points,
        projectedPoints.map((Vector point) => point.toOffset()).toList(),
        paint,
      );
    }

    if (showLines) {
      for (int i = 0; i < majorSegmentsCount; i++) {
        for (int j = 0; j < minorSegmentsCounts; j++) {
          final int currentIndex = i * minorSegmentsCounts + j;
          final int nextIndex =
              i * minorSegmentsCounts + (j + 1) % minorSegmentsCounts;
          final int nextRowIndex =
              ((i + 1) % majorSegmentsCount) * minorSegmentsCounts + j;

          connect(canvas, currentIndex, nextIndex, projectedPoints, paint);
          connect(canvas, currentIndex, nextRowIndex, projectedPoints, paint);
        }
      }
    }
  }
}
