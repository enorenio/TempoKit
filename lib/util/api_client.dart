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

import 'errors.dart';

class ApiClient {
  final http.Client client;
  final JsonEncoder jsonEncoder = JsonEncoder();

  ApiClient({this.client});

  final String baseUrl = 'tempokit.azurewebsites.net';

  Future<dynamic> _getJson(Uri uri, {Map<String, String> headers}) async {
    try {
      headers ??= {
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return AnyServerError(
          statusCode: response.statusCode,
          reasonPhrase: response.reasonPhrase,
        );
      }
    } catch (err) {
      //...
    }
  }

  Future<dynamic> _postJson(Uri uri,
      {Map<String, String> headers, body}) async {
    try {
      headers ??= {
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      };
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return AnyServerError(
          statusCode: response.statusCode,
          reasonPhrase: response.reasonPhrase,
        );
      }
    } catch (err) {
      //...
    }
  }

  //! User

  Future<dynamic> logIn({String uEmail, String password}) async {
    Uri url = Uri.https(baseUrl, 'auth');

    Map _bodyMap = {
      'u_email': uEmail,
      'password': password,
    };
    // String _body = jsonEncoder.convert(_bodyMap);

    dynamic _answer = await _postJson(
      url,
      body: _bodyMap,
    );

    return _answer;
  }

  Future<dynamic> register({User user}) async {
    Uri url = Uri.https(baseUrl, 'signup');

    Map _bodyMap = user.toJson();
    // String _body = jsonEncoder.convert(_bodyMap);

    dynamic _answer = await _postJson(
      url,
      body: _bodyMap,
    );

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
