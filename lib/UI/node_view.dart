import 'package:flutter/material.dart';
import 'package:rosflow/UI/node_painter.dart';
import 'package:rosflow/UI/node_graph.dart';
import 'package:rosflow/models/node.dart';

class NodeView extends StatefulWidget {
  NodeView(
      {required this.node,
      required this.initialX,
      required this.initialY,
      Key? key})
      : super(key: key) {}

  final Node node;
  final double initialX;
  final double initialY;

  @override
  _NodeViewState createState() => _NodeViewState();
}

class _NodeViewState extends State<NodeView> {
  double x = 0.0;
  double y = 0.0;

  _NodeViewState() {
    x = widget.initialX;
    y = widget.initialY;
  }

  void move(double x, double y)
  {
    setState(() {
      this.x += x;
      this.y += y;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: NodePainter(
          node: widget.node,
          x: x,
          y: y,
        ),
      ),
    );
  }
}
