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

  final List<Vector> points = [
    Vector(-50, -50, 0),
    Vector(50, -50, 0),
    Vector(50, 50, 0),
    Vector(-50, 50, 0),
  ];

  List<List<double>> projectionMatrix = [
    [1, 0, 0],
    [0, 1, 0],
  ];

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
                projectionMatrix: projectionMatrix,
              ),
            ),
          ),
        ),
      );
}
