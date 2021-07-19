import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' as gs;
import 'package:rosflow/models/node.dart';
import 'package:rosflow/models/topic.dart';

import 'node_graph_painter.dart';
import '../camera.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class NodeGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
// This widget is the root of your application.

}

class _MyAppState extends State<NodeGraph> {
  Camera globalCam = Camera();
  bool isDown = false;
  Offset startPosition = Offset(0, 0);

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
        startPosition = event.position;
      },
      onPointerUp: (gs.PointerUpEvent event) {
        isDown = false;
      },
      onPointerMove: (gs.PointerMoveEvent event) {
        if (isDown) {
          Offset offsetDelta = event.position - startPosition;
          startPosition = event.position;
          setState(() {
            globalCam.x += offsetDelta.dx;
            globalCam.y += offsetDelta.dy;
          });
        }
      },

      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: LayoutBuilder(
            // Inner yellow container
            builder: (_, constraints) => Container(
              width: constraints.widthConstraints().maxWidth,
              height: constraints.heightConstraints().maxHeight,
              child: CustomPaint(
                painter: NodeGraphPainter(
                  nodes: [
                    Node(name: "Node 1", inputTopics: [
                      Topic(name: "topic1", type: "std_msgs")
                    ], outputTopics: [
                      Topic(name: "outputTopic", type: "sensor_msgs")
                    ]),
                    Node(name: "Node 2", inputTopics: [
                      Topic(name: "topic1", type: "std_msgs")
                    ], outputTopics: [
                      Topic(name: "outputTopic", type: "sensor_msgs")
                    ])
                  ],
                  globalCamera: globalCam,
                ),
              ),
            ),
          )),
    );
  }
}
