import 'package:flutter/material.dart';

import 'package:tempokit/model/column.dart' as c;
import 'package:tempokit/model/task.dart';
import 'package:tempokit/view/home/project/new_task_view.dart';
import 'package:tempokit/view/home/project/task_list_view.dart';
import 'package:tempokit/view/widgets/gray_card.dart';

class ColumnView extends StatefulWidget {
  final dynamic columnAndTasks;

  ColumnView({this.columnAndTasks});
  _ColumnViewState createState() => _ColumnViewState();
}

class _ColumnViewState extends State<ColumnView> {
  @override
  Widget build(BuildContext context) {
    c.Column currentColumn = widget.columnAndTasks['column'];
    List<Task> currentTasks = widget.columnAndTasks['tasks'];
    List<dynamic> currentComments = widget.columnAndTasks['comments'];

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                currentColumn.name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              children: [
                GrayCard(
                  child: ListTile(
                    title: Icon(Icons.add),
                    onTap: () => showNewRequestView(column: currentColumn),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 0.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 0.0,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 4.0,
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .637,
                    ),
                    child: TaskListView(tasks: currentTasks, comments: currentComments)),
              ],
            ),
            // TaskListView(tasks:currentTasks),
          ],
        ),
      ),
    );
  }

  void showNewRequestView({c.Column column}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTaskView(
            column: column,
          );
        });
  }
}
