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
                ListTile(
                  title: GrayCard(
                    child: Icon(Icons.add),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 4.0,
                    ),
                  ),
                  onTap: () => showNewRequestView(column: currentColumn),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .648,
                    ),
                    child: TaskListView(tasks: currentTasks)),
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
