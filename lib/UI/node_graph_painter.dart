import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rosflow/UI/node_painter.dart';
import 'package:rosflow/models/node.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../camera.dart';

class NodeGraphPainter extends CustomPainter {
  Camera globalCamera;

  Vector4 boxPosTopLeft = Vector4(-0.5, -0.5, 0.0, 1.0);
  Vector4 boxPosBottomRight = Vector4(0.5, 0.5, 0.0, 1.0);
  final List<NodePainter> nodeViews;
  static const int step = 100;
  static const int min = -30000;
  static const int max = 30000;

  NodeGraphPainter({required this.globalCamera, required this.nodeViews}) {
  }

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.blueGrey;

    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.save();

    canvas.translate(globalCamera.x, globalCamera.y);
    canvas.scale(globalCamera.scale);

    //horizontal Lines
    for (int i = min; i < max; i += step) {
      canvas.drawLine(Offset(min.toDouble(), i.toDouble()),
          Offset(max.toDouble(), i.toDouble()), gridPaint);
    }

    //vertial Lines
    for (int i = min; i < max; i += step) {
      canvas.drawLine(Offset(i.toDouble(), min.toDouble()),
          Offset(i.toDouble(), max.toDouble()), gridPaint);
    }

    for (var nView in nodeViews) {
      nView.paint(canvas, size);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
