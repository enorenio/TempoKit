import 'package:flutter/material.dart';
import '../../model/project.dart';
import '../../model/task.dart';
import '../../model/column.dart' as c;

class DeleteButton extends StatelessWidget {
  final Task task;
  final c.Column column;
  final Project project;

  DeleteButton({Key key, this.task, this.column, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 80,
            child: Column(children: <Widget>[
              Icon(Icons.drag_handle),
              ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: (){
                print(task.taskId);
              },
            )
            ],),
          );
  }
}
