import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_3d_rendering/render_painter.dart';
import 'package:flutter_3d_rendering/vector.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double angle = 0;

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

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(milliseconds: 16),
      (Timer timer) => setState(() => angle += 0.02),
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CustomPaint(
              size: const Size(400, 400),
              painter: RenderPainter(
                angle: angle,
                points: points,
              ),
            ),
          ),
        ),
      );
}
