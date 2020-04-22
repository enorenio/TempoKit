import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/repository.dart';

import '../../injection_container.dart';

class TasksListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<Repository>().getTasks(),
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
          return tile(data[index].name, data[index].description);
        });
  }

  ListTile tile(String title, String subtitle) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      );
}
