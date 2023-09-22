import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_3d_rendering/render_painter.dart';
import 'package:flutter_3d_rendering/shape_renderer/donut_renderer.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double angleX = 0;
  double angleY = 0;
  double angleZ = 0;
  int majorSegmentsCount = 64;
  int minorSegmentsCounts = 32;
  bool showPoints = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildRendererPainter(),
                _buildShowPoints(),
                _buildShowLines(),
                _buildAngleXSlider(),
                _buildAngleYSlider(),
                _buildAngleZSlider(),
                _buildMajorSegmentsCountSlider(),
                _buildMinorSegmentsCountSlider(),
              ],
            ),
          ),
        ),
      );

  Widget _buildRendererPainter() => CustomPaint(
        size: const Size(500, 500),
        painter: RenderPainter(
          DonutRenderer(
            angleX: angleX,
            angleY: angleY,
            angleZ: angleZ,
            majorSegmentsCount: majorSegmentsCount,
            minorSegmentsCounts: minorSegmentsCounts,
            showPoints: showPoints,
            showLines: !showPoints,
          ),
        ),
      );

  Widget _buildShowLines() => CheckboxListTile(
        value: !showPoints,
        title: const Text('Show Lines'),
        onChanged: (_) => setState(() => showPoints = !showPoints),
      );

  Widget _buildShowPoints() => CheckboxListTile(
        value: showPoints,
        title: const Text('Show Points'),
        onChanged: (_) => setState(() => showPoints = !showPoints),
      );

  Widget _buildAngleXSlider() => Column(
        children: <Widget>[
          Text(
            'Angle X: ${angleX.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: angleX,
            max: pi,
            onChanged: (double value) => setState(() => angleX = value),
          ),
        ],
      );

  Widget _buildAngleYSlider() => Column(
        children: <Widget>[
          Text(
            'Angle Y: ${angleY.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: angleY,
            max: pi,
            onChanged: (double value) => setState(() => angleY = value),
          ),
        ],
      );

  Widget _buildAngleZSlider() => Column(
        children: <Widget>[
          Text(
            'Angle Z: ${angleZ.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: angleZ,
            max: pi,
            onChanged: (double value) => setState(() => angleZ = value),
          ),
        ],
      );

  Widget _buildMajorSegmentsCountSlider() => Column(
        children: <Widget>[
          Text(
            'Major Segments Count: $majorSegmentsCount',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: majorSegmentsCount.toDouble(),
            max: 128,
            onChanged: (double value) =>
                setState(() => majorSegmentsCount = value.toInt()),
          ),
        ],
      );

  Widget _buildMinorSegmentsCountSlider() => Column(
        children: <Widget>[
          Text(
            'Minor Segments Count: $minorSegmentsCounts',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: minorSegmentsCounts.toDouble(),
            max: 64,
            onChanged: (double value) =>
                setState(() => minorSegmentsCounts = value.toInt()),
          ),
        ],
      );
}
