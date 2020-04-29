import 'package:flutter/material.dart';

import '../../model/task.dart';

class TaskView extends StatefulWidget {
  final Task task;
  const TaskView({Key key, this.task}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _commentController = new TextEditingController();

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
            SizedBox(
              height: 20,
            ),
            Text(
              "No comments",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _commentController,
              cursorColor: Color(0xFF3C4858),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: 'Leave a comment...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      print("Sent: " + _commentController.text);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}