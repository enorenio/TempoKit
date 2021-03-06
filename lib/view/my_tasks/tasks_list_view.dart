import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/bloc/my_tasks/my_tasks_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/widgets/task_view.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';

class TasksListView extends StatefulWidget {
  @override
  _TasksListViewState createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<MyTasksBloc>(context).add(GetMyTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTasksBloc, MyTasksState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (state is MyTasksError) {
        showError(context, state);
      } else if (state is TasksState) {
        if (state.tasks.length > 0) {
          return tasksListView(context: context, tasks: state.tasks);
        } else {
          return Center(
            child: Text('No tasks created yet'),
          );
        }
      }
      return tempWidget;
    });
  }

  ListView tasksListView({BuildContext context, List<Task> tasks}) {
    return ListView.separated(
        separatorBuilder: (context,index)=>Divider(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return tile(context, tasks[index]);
        });
  }

  ListTile tile(BuildContext context, Task task) => ListTile(
        leading: Icon(Icons.assignment_turned_in,color: Colors.greenAccent,),
        title: Text(task.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        onTap: () {
          print("You pressed task tile!");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskView(
                  task: task,
                ),
              ));
        },
      );
}
