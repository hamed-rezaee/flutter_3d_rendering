import 'package:flutter/material.dart';

import 'package:flutter_3d_rendering/shape_renderer/base_renderer.dart';

class RenderPainter extends CustomPainter {
  RenderPainter(this.renderer);

  final BaseRenderer renderer;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.black,
      )
      ..translate(size.width / 2, size.height / 2);

    renderer.render(
      canvas,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
