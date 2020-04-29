import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/bloc/inbox/inbox_bloc.dart';
import '../account/account_page.dart';
import 'package:tempokit/util/errors.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key key}) : super(key: key);

  @override
  InboxPageState createState() => InboxPageState();
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
                child: ChipRow(),
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
                      return MyCont(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            taskTitle(task.name),
                            Divider(),
                            task.dueDate == null
                                ? taskText('You have task due ${task.dueDate}')
                                : null, //TODO: display something?
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: 110,
                                  child: RaisedButton(
                                    color: Color.fromRGBO(60, 60, 60, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      //showNewCompanyView();
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
                                  child: RaisedButton(
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
}

class ChipRow extends StatefulWidget {
  @override
  _ChipRowState createState() => _ChipRowState();
}

class _ChipRowState extends State<ChipRow> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = Theme.of(context).textTheme.body2;
    Color _selectedColor = Theme.of(context).accentColor;

    onSelected(index) {
      return (bool selected) {
        setState(() {
          _value = selected ? index : null;
        });
      };
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(width: 16.0),
        ChoiceChip(
          label: Text(
            'All',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 0,
          onSelected: onSelected(0),
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            'Assigned to me',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 1,
          onSelected: onSelected(1),
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            '@Mentioned',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 2,
          onSelected: onSelected(2),
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            'Assigned by me',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 3,
          onSelected: onSelected(3),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

taskTitle(title) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
    child: Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
    ),
  );
}

taskText(text) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    ),
  );
}

String comment; //TODO: delete global variable

class NewCommentView extends StatelessWidget {
  final commentController = TextEditingController();
  final commentFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: commentFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter column name!';
                  },
                  controller: commentController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Column name...',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromRGBO(60, 60, 60, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      if (commentFormKey.currentState.validate()) {
                        Navigator.pop(context);
                        handleNewComment();
                      }
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  handleNewComment() {
    comment = commentController.text;
  }
}
