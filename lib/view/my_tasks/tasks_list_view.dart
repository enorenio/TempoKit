import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Task {
  final String title;

  Task({this.title});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
    );
  }
}

class TasksListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Task> data = snapshot.data;
          return tasksListView(data);
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

  ListView tasksListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return tile(data[index].title);
        });
  }

  ListTile tile(String title) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      );
}