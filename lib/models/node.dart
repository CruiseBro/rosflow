import 'package:rosflow/models/topic.dart';

class Node {
  String name;
  List<Topic> inputTopics;
  List<Topic> outputTopics;

  Node(
      {required this.name,
      required this.inputTopics,
      required this.outputTopics}) {}
}
