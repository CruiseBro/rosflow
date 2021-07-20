import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' as gs;
import 'package:rosflow/models/node.dart';
import 'package:rosflow/models/topic.dart';

import 'node_graph_painter.dart';
import '../camera.dart';
import 'node_painter.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class NodeGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
// This widget is the root of your application.

}

class _MyAppState extends State<NodeGraph> {
  final marginx = 40.0;
  final marginy = 80.0;
  Camera globalCam = Camera();
  bool isDown = false;
  Offset startPosition = Offset(0, 0);
  List<NodePainter> nodeViews = [];
  NodePainter? selectedNode;

  @override
  void initState() {
    nodeViews.add(NodePainter(
        x: 0.0,
        y: 0.0,
        node: Node(name: "Node 1", inputTopics: [
          Topic(name: "input topic 1", type: "std_msgs/String")
        ], outputTopics: [
          Topic(name: "output topic 1", type: "std_msgs/String")
        ])));
    nodeViews.add(NodePainter(
        x: 500,
        y: 0,
        node: Node(name: "Node 2", inputTopics: [
          Topic(name: "input topic 2", type: "std_msgs/String")
        ], outputTopics: [
          Topic(name: "output topic 1", type: "std_msgs/String")
        ])));
  }

  NodePainter? hitNode(double x, double y) {
    final double cx = (x - globalCam.x  - marginx) / globalCam.scale;
    final double cy = (y  - globalCam.y - marginy) / globalCam.scale;
    for (var node in nodeViews) {
      if (node.isWithinHead(cx, cy)) {
        return node;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (gs.PointerSignalEvent event) {
        if (event is gs.PointerScrollEvent) {
          double scrollDelta = event.scrollDelta.dy;
          setState(() {
            globalCam.scale += scrollDelta * -0.001;
          });
        }
      },
      onPointerDown: (gs.PointerDownEvent event) {
        isDown = true;
        selectedNode = hitNode(event.position.dx, event.position.dy);
        startPosition = event.position;
      },
      onPointerUp: (gs.PointerUpEvent event) {
        isDown = false;
        selectedNode = null;
      },
      onPointerMove: (gs.PointerMoveEvent event) {
        if (isDown) {
          Offset offsetDelta = event.position - startPosition;
          startPosition = event.position;
          if (selectedNode == null) {
            setState(() {
              globalCam.x += offsetDelta.dx;
              globalCam.y += offsetDelta.dy;
            });
          }
          else {
            setState(() {
              selectedNode!.move(offsetDelta.dx / globalCam.scale, offsetDelta.dy / globalCam.scale);
            });
          }
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: marginx, vertical: marginy),
          child: LayoutBuilder(
            // Inner yellow container
            builder: (_, constraints) => Container(
              width: constraints.widthConstraints().maxWidth,
              height: constraints.heightConstraints().maxHeight,
              child: CustomPaint(
                painter: NodeGraphPainter(
                  nodeViews: nodeViews,
                  globalCamera: globalCam,
                ),
              ),
            ),
          )),
    );
  }
}
