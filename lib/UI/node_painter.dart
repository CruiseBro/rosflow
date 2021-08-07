import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rosflow/models/node.dart';

enum FocusStatus { selected, hovered, none }

class NodePainter extends CustomPainter {
  Node node;
  double x;
  double y;

  late TextSpan textSpan;

  final width = 500.0;
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

  List<TextPainter> inputTopicPainter = [];
  List<TextPainter> outputTopicPainter = [];

  NodePainter({required this.node, this.x = 0.0, this.y = 0.0}) {
    textSpan = TextSpan(
        style: new TextStyle(color: Colors.white70, fontSize: 36),
        text: node.name);
    tp = TextPainter(text: textSpan, textAlign: TextAlign.left);
    tp.textDirection = TextDirection.ltr;
    tp.layout();

    for (var topic in node.inputTopics) {
      print("topic name: ${topic.name}");
      var painter = TextPainter(
          text: TextSpan(
              style: TextStyle(color: Colors.indigo, fontSize: 24),
              text: topic.name),
          textAlign: TextAlign.left);
      painter.textDirection = TextDirection.ltr;
      painter.layout();
      inputTopicPainter.add(painter);
    }

    for (var topic in node.outputTopics) {
      print("topic name: ${topic.name}");
      var painter = TextPainter(
          text: TextSpan(
              style: TextStyle(color: Colors.indigo, fontSize: 24),
              text: topic.name),
          textAlign: TextAlign.left);
      painter.textDirection = TextDirection.ltr;
      painter.layout();
      outputTopicPainter.add(painter);
    }
  }

  bool isWithinHead(double probex, double probey) {
    return probex >= x &&
        probex <= x + width &&
        probey >= y &&
        probey <= y + topBarHeight;
  }

  void move(double dx, double dy) {
    x += dx;
    y += dy;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, width, topBarHeight), Radius.circular(2.0)),
        paintFilled);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, width, topBarHeight + 200.0),
            Radius.circular(2.0)),
        paintStroke);

    _paintNodeName(canvas);
    _paintInputTopics(canvas);
    _paintOutputTopics(canvas);
  }

  void _paintNodeName(Canvas canvas) {
    double textDeltaY = (topBarHeight - tp.height) / 2;
    double textDeltaX = (width - tp.width) / 2;
    tp.paint(canvas, Offset(x + textDeltaX, y + textDeltaY));
  }

  void _paintInputTopics(Canvas canvas) {
    double dy = 60;
    double offsetY = y + topBarHeight + 20;
    double offsetX = x + 5;
    for (var topicTextPainter in inputTopicPainter) {
      topicTextPainter.paint(canvas, Offset(offsetX, offsetY));
      offsetY += dy;
    }
  }

  void _paintOutputTopics(Canvas canvas) {
    double dy = 60;
    double offsetY = y + topBarHeight + 20;
    double offsetX = x - 5;

    for (var topicTextPainter in outputTopicPainter) {
      topicTextPainter.paint(canvas,
          Offset(offsetX + width - topicTextPainter.width, offsetY));
      offsetY += dy;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
