import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/model/column.dart' as c;
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/view/home/project/users_list_view.dart';

class NewTaskView extends StatefulWidget {
  final c.Column column;

  NewTaskView({Key key, this.column}) : super(key: key);

  @override
  _NewTaskViewState createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  final _taskNameController = TextEditingController();

  final _taskDescriptionController = new TextEditingController();

  DateTime _dateTime;

  final _requestFormKey = GlobalKey<FormState>();
  List<String> tags = ["UI", "Monetization", "Design", "Code", "Bugs"];
  List<String> selectedTags = new List();

  // GlobalKey<_MyItemState> itemGlobalKey = new GlobalKey<_MyItemState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Form(
        key: _requestFormKey,
        child: ListView(
          children: <Widget>[
            Icon(Icons.drag_handle),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                return value.isEmpty ? 'Please enter task name!' : null;
              },
              controller: _taskNameController,
              cursorColor: Color(0xFF3C4858),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Task name...',
              ),
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return UsersListView(
                                  allUsers: []); //TODO: pass here users or make request and get them
                            });
                      },
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
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050))
                          .then((date) {
                        _dateTime = date;
                      });
                    },
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
            SizedBox(height: 20),
            Container(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return tagChip(tags[index]);
                    })),
            SizedBox(height: 20),
            TextFormField(
                controller: _taskDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Color(0xFF3C4858),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Description...',
                )),
            SizedBox(height: 20),
            ButtonTheme(
              minWidth: 150,
              child: RaisedButton(
                color: Color.fromRGBO(60, 60, 60, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  _handleNewTask(
                    context: context,
                    column: widget.column,
                  );
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

  void _handleNewTask({BuildContext context, c.Column column}) async {
    if (_requestFormKey.currentState.validate()) {
      BlocProvider.of<HomeBloc>(context).add(
        CreateTaskEvent(
          task: Task(
            name: _taskNameController.text,
            description: _taskDescriptionController.text,
            colId: column.colId,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  FilterChip tagChip(String text) => FilterChip(
        label: Text(text),
        selected: selectedTags.contains(text),
        onSelected: (value) {
          setState(() {
            if (selectedTags.contains(text)) {
              selectedTags.remove(text);
            } else {
              selectedTags.add(text);
            }
          });
        },
      );
}
