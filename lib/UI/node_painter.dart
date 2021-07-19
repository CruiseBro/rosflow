import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rosflow/models/node.dart';

enum FocusStatus {
  selected, hovered, none
}

class NodePainter extends CustomPainter {
  Node node;
  double x;
  double y;

  late TextSpan textSpan;

  final width = 400.0;
  final topBarHeight = 100.0;

  final paintStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.indigo;

  final paintFilled = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0
    ..color = Colors.indigo;

  late TextPainter tp;

  NodePainter({required this.node, this.x = 0.0, this.y = 0.0})
  {
    textSpan = TextSpan(style: new TextStyle(color: Colors.white70, fontSize: 36), text: node.name);
    tp = TextPainter(text: textSpan, textAlign: TextAlign.left);
    tp.textDirection = TextDirection.ltr;
    tp.layout();
  }

  @override
  void paint(Canvas canvas, Size size) {

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, width, topBarHeight), Radius.circular(2.0)),
        paintFilled);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, width, topBarHeight + 200.0), Radius.circular(2.0)),
        paintStroke);

    double textDeltaY = (topBarHeight - tp.height) / 2;
    double textDeltaX = (width - tp.width) / 2;
    tp.paint(canvas, Offset(x + textDeltaX, y + textDeltaY));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
