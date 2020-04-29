import 'package:flutter/material.dart';
import 'tasks_list_view.dart';

class MyTasksPage extends StatefulWidget {
  const MyTasksPage({Key key}) : super(key: key);

  @override
  _MyTasksPageState createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("My Tasks"),
      ),
      body: Center(child: TasksListView()),
    );
  }
}
