import 'package:flutter/material.dart';


class TaskView extends StatefulWidget {
  const TaskView({Key key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("My Tasks"),
      ),
    );
  }

}
