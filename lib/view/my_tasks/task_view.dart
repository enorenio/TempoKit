import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  final String taskName;
  const TaskView({Key key, this.taskName}) : super(key: key);

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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            widget.taskName,
            style: TextStyle(fontSize: 30),
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
          Text("Description"),
          SizedBox(
            height: 20,
          ),
          Text("Comments"),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _commentController,
            cursorColor: Color(0xFF3C4858),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                hintText: 'Task name...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    print("Sent: " + _commentController.text);
                  },
                )),
          ),
        ],
      ),
    );
  }
}
