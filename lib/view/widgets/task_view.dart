import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/tag.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/view/widgets/gray_card.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';

class TaskView extends StatefulWidget {
  final Task task;
  const TaskView({Key key, this.task}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _commentController = new TextEditingController();

  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context)
        .add(GetTaskViewInfoEvent(task: widget.task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is TaskViewInfoState) {
        return Scaffold(
          appBar: new AppBar(
            leading: BackButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context)
                    .add(GetColumnsAndTasksEvent());
                return Navigator.pop(context);
              },
            ),
            title: Text("Task Info"),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ScrollConfiguration(
              behavior: NoScrollGlow(),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 80 - 57,
                  child: SafeArea(
                    minimum: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.task.name,
                              style: Theme.of(context).textTheme.title,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 150,
                              child: FlatButton.icon(
                                  icon: Icon(Icons.person_outline, size: 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  onPressed: () {},
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  label: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Assigned to:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Username',
                                        style: TextStyle(
                                            color: Colors.white,
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                onPressed: () {},
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                label: Text(
                                  'Due Date',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GrayCard(
                          // child:
                          child: widget.task.description != null &&
                                  widget.task.description != ''
                              ? Text(
                                  widget.task.description,
                                  style: Theme.of(context).textTheme.body1,
                                )
                              : Center(
                                  child: Text(
                                  "No Description",
                                  style: Theme.of(context).textTheme.body1,
                                )),
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        if (state.tags.length > 0)
                          Container(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 8,
                              ),
                              itemCount: state.tags.length,
                              itemBuilder: (context, index) {
                                Tag currentTag = state.tags[index];
                                return Chip(
                                  label: Text(currentTag.name),
                                  backgroundColor: Color(int.parse(
                                      'FF${currentTag.color}',
                                      radix: 16)),
                                );
                              },
                            ),
                          ),
                        if (state.comments.length > 0)
                          commentsListView(
                              context: context, comments: state.comments),
                        if (state.comments.length == 0)
                          showEmptyCommentsSpace(),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _commentController,
                                onEditingComplete: _sendComment,
                                cursorColor: Color(0xFF3C4858),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    hintText: 'Leave a comment...',
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: _sendComment,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }

  Widget commentsListView({BuildContext context, List<Comment> comments}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromRGBO(0, 0, 0, 0.3),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(13, 51, 32, 0.1),
              offset: Offset(0.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        margin: EdgeInsets.symmetric(vertical: 16),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(
            height: 4,
          ),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            Comment currentComment = comments[index];
            return RichText(
              text:
                  TextSpan(style: Theme.of(context).textTheme.body1, children: [
                TextSpan(
                    text: '${currentComment.uEmail}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(text: currentComment.text),
              ]),
            );
          },
        ),
      ),
    );
  }

  Widget showEmptyCommentsSpace() => Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(0, 0, 0, 0.3),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(13, 51, 32, 0.1),
                offset: Offset(0.0, 6.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('No comments yet.'),
              Text('Be first!'),
            ],
          )),
        ),
      );

  ListTile tile(BuildContext context, Comment comment) => ListTile(
        title: Text(comment.text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      );

  void _sendComment() {
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<HomeBloc>(context).add(
      CreateCommentEvent(
          comment: new Comment(
            text: _commentController.text,
          ),
          task: widget.task),
    );
    _commentController.text = '';
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
