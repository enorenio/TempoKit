
import 'package:flutter/material.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/view/widgets/gray_card.dart';
import 'package:tempokit/view/widgets/task_view.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  const TaskListView({Key key, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task current = tasks[index];
          return TaskTile(
            task: current,
          );
        });
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GrayCard(
        child: Text(task.name),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 4.0,
        ),
      ),
      onTap: () => _openTask(context),
    );
  }

  void _openTask(BuildContext context) {
    print("You pressed task tile!");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskView(
          task: task,
        ),
      ),
    );
  }
}
