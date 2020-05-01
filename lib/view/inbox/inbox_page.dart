import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/bloc/inbox/inbox_bloc.dart';
import 'package:tempokit/view/widgets/gray_card.dart';
import 'package:tempokit/util/errors.dart';

import 'chip_row_view.dart';
import 'new_comment_view.dart';

import 'dart:math';

  List<Color> colors = [
    Colors.pinkAccent,
    Colors.deepOrangeAccent[700],
    Colors.blueAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.indigoAccent,
    Colors.tealAccent,
    Colors.deepPurpleAccent,
    Colors.yellowAccent,
  ];
class InboxPage extends StatefulWidget {
  const InboxPage({Key key}) : super(key: key);
  @override
  InboxPageState createState() => InboxPageState();

  //setState(Map map) {}
   
  }

class InboxPageState extends State<InboxPage> {

  @override
  initState() {
    super.initState();
    BlocProvider.of<InboxBloc>(context).add(((GetMyTasksEvent())));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InboxBloc, InboxState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return Center(child: CircularProgressIndicator());
      } else if (state is InboxError) {
        showError(context, state);
      }
      if (state is TasksState && state.tasks.length > 0) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Container(
                height: 32.0,
                child: ChipRow(this),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    physics: BouncingScrollPhysics(),
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = state.tasks[index];
                      return GrayCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            taskTitle(task.name),
                            Divider(),
                            Row(
                              children: <Widget>[
                              Icon(Icons.arrow_forward_ios, size: 60,color: colors[Random().nextInt(colors.length)]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                 taskText(task.description),
                                   task.dueDate == null
                                  ? taskText('Due to ${task.dueDate}')
                                  : null, //TODO: display something?  
                              ], 
                              ),
                            ], ),
                           
                            Divider(),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: 110,
                                  child: OutlineButton(
                                    highlightedBorderColor: Theme.of(context).accentColor,
                                    color: Color.fromRGBO(60, 60, 60, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      leaveTask(task.taskId);
                                    },
                                    child: Text(
                                      'Leave',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                ButtonTheme(
                                  minWidth: 110,
                                  child: OutlineButton(
                                    highlightedBorderColor: Theme.of(context).accentColor,
                                    color: Color.fromRGBO(60, 60, 60, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      leaveCommentView(task.taskId);
                                    },
                                    child: Text(
                                      'Comment',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        );
      }
      return Center(
        child: Text('No notifications available'),
      );
      
    });
  }

  leaveCommentView(taskId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewCommentView();
        });
    BlocProvider.of<InboxBloc>(context).add(
        CreateCommentEvent(comment: Comment(text: comment), taskId: taskId));
  }

  leaveTask(taskId){
   print('Task was left');
   
}


}


taskText(text) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    child: Text(

      text,
      style: TextStyle(fontSize: 16.0,),
    ),
  );
}

