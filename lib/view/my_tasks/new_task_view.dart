import 'package:flutter/material.dart';
import 'package:tempokit/model/user.dart';

class NewTaskView extends StatelessWidget {
  final _taskNameController = new TextEditingController();
  final _taskDescriptionController = new TextEditingController();
  final _taskFormKey = GlobalKey<FormState>();
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: _taskFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter task name!';
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
                                  return AlertDialog(
                                      content: Container(
                                          height: 200,
                                          width: 200,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Form(
                                                  child: FutureBuilder(
                                                future: _fetchUsers(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<User> data =
                                                        snapshot.data;
                                                    return ListView.builder(
                                                        itemCount: data.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return userTile(
                                                              data[index]
                                                                  .uEmail);
                                                        });
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        "${snapshot.error}");
                                                  }
                                                  return CircularProgressIndicator();
                                                },
                                              )),
                                              ButtonTheme(
                                                minWidth: 150,
                                                child: RaisedButton(
                                                  color: Color.fromRGBO(
                                                      60, 60, 60, 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0)),
                                                  onPressed: () {
                                                    if (_taskFormKey
                                                        .currentState
                                                        .validate()) {
                                                      Navigator.pop(context);
                                                      print(
                                                          "New task created: " +
                                                              _taskNameController
                                                                  .text);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Assign',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.amber[800],
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )));
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
                      if (_taskFormKey.currentState.validate()) {
                        Navigator.pop(context);
                        print("New task created: " + _taskNameController.text);
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

  Future<List<User>> _fetchUsers() async {
    // final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    // final response = await http.get(jobsListAPIUrl);

    // if (response.statusCode == 200) {
    //   List jsonResponse = json.decode(response.body);
    //   return jsonResponse.map((job) => new Task.fromJson(job)).toList();
    // } else {
    //   throw Exception('Failed to load jobs from API');
    // }
  }
  ListTile userTile(String title) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        onTap: () {
          print("You pressed task tile!");
        },
      );
}
