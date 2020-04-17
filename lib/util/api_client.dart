import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tempokit/model/column.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/file.dart';
import 'package:tempokit/model/milestone.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/report.dart';
import 'package:tempokit/model/tag.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/model/user.dart';

class ApiClient {
  final http.Client client;

  ApiClient({this.client});

  final String baseUrl = 'api.someurl.org';

  Future<dynamic> _getJson(Uri uri) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        //...
      }
    } catch (err) {
      //...
    }
  }

  //! User

  Future<User> logIn({String uEmail, String password}) async {
    // Uri url = Uri.https(baseUrl, 'user/login', {});

    // dynamic json = await _getJson(url);
    // return json['answer'];
    User _user = await Future.delayed(Duration(seconds: 2), () {
      return User(
        uEmail: 'morshnev.aleksey@gmail.com',
        fullName: 'Aleksey Morshnev',
        password: '12345',
        workType: 'dev',
      );
    });
    return _user;
  }

  Future<bool> register({User user}) async {
    // Uri url = Uri.https(baseUrl, 'user/register', {});

    // dynamic json = await _getJson(url);
    // return json['answer'];
    bool _answer = await Future.delayed(Duration(seconds: 2), () {
      return true;
    });
    return _answer;
  }

  //! Project

  Future<List<Project>> getProjects(
      {bool isFavorited = false, String uEmail, int compId}) async {
    Uri url = isFavorited
        ? Uri.https(baseUrl, 'project/favorited', {})
        : Uri.https(baseUrl, 'project', {});

    dynamic json = await _getJson(url);
    return json.map<Project>((item) => Project.fromJson(item)).toList();
  }

  dynamic createProject() async {}

  dynamic editProject() async {}

  dynamic deleteProject() async {}

  //! Task

  dynamic getTasks() async {}

  dynamic createTask() async {}

  dynamic editTask() async {}

  dynamic deleteTask() async {}

  //! Column

  dynamic createColumn() async {}

  dynamic editColumn() async {}

  dynamic deleteColumn() async {}

  //! Company

  dynamic getAllCompanies() async {}

  dynamic createCompany() async {}

  //! Tag

  dynamic getAllTags() async {}

  dynamic createTag() async {}

  dynamic editTag() async {}

  dynamic deleteTag() async {}

  //! Comment

  dynamic getAllComments() async {}

  dynamic createComment() async {}

  dynamic editComment() async {}

  dynamic deleteComment() async {}

  //! File

  dynamic getAllFiles() async {}

  dynamic uploadFile() async {}

  dynamic deleteFile() async {}

  //! Milestone

  dynamic getAllMilestones() async {}

  dynamic createMilestone() async {}

  dynamic editMilestone() async {}

  dynamic deleteMilestone() async {}

  //! Report

  dynamic getReports() async {}

  dynamic createReport() async {}

  //! Search

  dynamic search() async {}
}
