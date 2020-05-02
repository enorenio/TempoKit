import 'package:flutter/material.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/view/widgets/delete_button.dart';
import 'package:tempokit/view/widgets/gray_card.dart';
import 'package:tempokit/view/widgets/task_view.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final List<dynamic> comments;
  const TaskListView({Key key, this.tasks, this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task current = tasks[index];
          int commentAmount = comments.firstWhere((item) =>
              item['task_id'] == current.taskId)['number_of_comments'];
          return TaskTile(
            task: current,
            commentAmount: commentAmount,
          );
        });
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final int commentAmount;
  const TaskTile({Key key, this.task, this.commentAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GrayCard(
      child: ListTile(
          title: Text(task.name),
          subtitle: task.description != null && task.description != ''
              ? Text(
                  task.description,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: _trailingComment(context),
          onTap: () => _openTask(context),
          onLongPress:() {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return DeleteButton(task: task);
                    });
              },
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 0.0,
          )),
      padding: EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 0.0,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 4.0,
      ),
    );
    // return
  }

  Widget _trailingComment(BuildContext context) {
    if (commentAmount > 999) {
      return SizedBox(
        width: 50,
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              height: 17,
              width: 17,
              child: Icon(Icons.comment, size: 17),
            ),
          ],
        ),
      );
    }
    if (commentAmount > 0) {
      return SizedBox(
        width: 50,
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              child: Text(
                '$commentAmount',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            SizedBox(
              height: 17,
              width: 17,
              child: Icon(Icons.comment, size: 17),
            ),
          ],
        ),
      );
    } else {
      return null;
    }
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
