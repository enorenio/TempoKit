import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/repository.dart';
import 'package:tempokit/view/my_tasks/task_view.dart';

import '../../injection_container.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({Key key}) : super(key: key);

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  List<Task> selectedUsers = new List<Task>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Assign to:"),
      content: Container(
          height: 400,
          width: 300,
          child: Column(
            children: <Widget>[
              Container(
                height: 325,
                child: FutureBuilder(
                  future: sl<Repository>().getColumnsAndTasks(), //TODO: delete this
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Task> data = snapshot.data;
                      return usersListView(context, data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: CircularProgressIndicator()
                      );
                  },
                ),
              ),
              SizedBox(
                height: 27,
              ),
              ButtonTheme(
                minWidth: 150,
                child: RaisedButton(
                  color: Color.fromRGBO(60, 60, 60, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {},
                  child: Text(
                    'Assign',
                    style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<List<Task>> _fetchTasks() async {
    // final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    // final response = await http.get(jobsListAPIUrl);

    // if (response.statusCode == 200) {
    //   List jsonResponse = json.decode(response.body);
    //   return jsonResponse.map((job) => new Task.fromJson(job)).toList();
    // } else {
    //   throw Exception('Failed to load jobs from API');
    // }
  }
  ListView usersListView(context, data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return userTile(data[index]);
        });
  }

  CheckboxListTile userTile(Task task) => CheckboxListTile(
        title: Text(task.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        value: selectedUsers.contains(task)?true:false,
        onChanged: (bool value) {
          setState(() {
            if(selectedUsers.contains(task)){
              selectedUsers.remove(task);
            }else{
              selectedUsers.add(task);
            }
          });
        },
      );
}
