import 'package:flutter/material.dart';
import 'package:tempokit/view/widgets/gray_card.dart';

import '../../model/comment.dart';
import '../../model/comment.dart';
import '../../model/comment.dart';
import '../../model/task.dart';
import '../../util/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';
import '../../util/bloc/home/home_bloc.dart';
import 'loading_widget.dart';

class TaskView extends StatefulWidget {
  final Task task;
  const TaskView({Key key, this.task}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetCommentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Task Info"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              widget.task.name,
              style: TextStyle(
                  fontSize: 35, color: Color.fromRGBO(0, 212, 106, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 150,
                  child: FlatButton.icon(
                      icon: Icon(Icons.supervised_user_circle, size: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {},
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Assigned to:',
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Username',
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: FlatButton.icon(
                    icon: Icon(Icons.date_range, size: 40),
                    onPressed: () {},
                    label: Text(
                      'Due Date',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Description:",
              style: TextStyle(
                  color: Color.fromRGBO(231, 60, 112, 1), fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.task.description != null
                  ? widget.task.description
                  : "No Description.",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Comments:",
              style: TextStyle(
                  color: Color.fromRGBO(231, 60, 112, 1), fontSize: 25),
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is Loading) {
                print('$this loading');
                return loadingWidget;
              } else if (state is CommentsState) {
                if (state.comments.length > 0) {
                  return commentsListView(
                      context: context, comments: state.comments);
                } else {
                  List<Comment> comments = new List(1);
                  comments[0] = new Comment(text: "No comments");
                  return commentsListView(context: context, comments: comments);
                }
              }
              return Container(height: 10);
            }),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Container commentsListView({BuildContext context, List<Comment> comments}) {
    final _commentController = new TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Column(
            children: [
              ...(comments
                  .map((comment) => ListTile(
                        title: Text(comment.text),
                      ))
                  .toList()),
              TextFormField(
                controller: _commentController,
                cursorColor: Color(0xFF3C4858),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    hintText: 'Leave a comment...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          CreateCommentEvent(
                              comment: new Comment(
                                text: _commentController.text,
                              ),
                              taskId: widget.task.taskId),
                        );
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListTile tile(BuildContext context, Comment comment) => ListTile(
        title: Text(comment.text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      );
}
