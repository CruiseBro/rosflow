import 'package:flutter/material.dart';
import 'package:rosflow/UI/node_graph_painter.dart';
import 'package:rosflow/UI/node_graph.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // Outer white container with padding
            body: NodeGraph()));
  }
}
