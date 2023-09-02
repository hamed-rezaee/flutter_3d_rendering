import 'package:flutter/material.dart';

class Vector {
  Vector(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  Offset toOffset() => Offset(x, y);

  List<double> toList() => [x, y, z];



  @override
  String toString() => 'Vector($x, $y, $z)';
}
