import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'tasks_list_view.dart';
import 'new_task_view.dart';

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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showNewTaskView();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red),
    );
  }

  void showNewTaskView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTaskView();
        });
  }
}
