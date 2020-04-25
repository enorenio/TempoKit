import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/repository.dart';
import 'package:tempokit/view/my_tasks/task_view.dart';

import '../../injection_container.dart';

class TasksListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<Repository>().getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Task> data = snapshot.data;
          return tasksListView(context,data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
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

  ListView tasksListView(context, data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return tile(context, data[index].name);
        });
  }

  ListTile tile(BuildContext context,String title) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        onTap: () {
          print("You pressed task tile!");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskView(taskName: title,),
              ));
        },
      );
}

class Context {
}
