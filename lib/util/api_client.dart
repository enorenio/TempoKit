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

import 'cache_controller.dart';
import 'consts.dart';
import 'errors.dart';

class ApiClient {
  final http.Client client;
  final CacheController cacheController;
  final JsonEncoder jsonEncoder = JsonEncoder();
  String token;

  ApiClient({this.client, this.cacheController});

  final String baseUrl = 'tempokit.azurewebsites.net';

  Future<dynamic> _getJson(Uri uri, {Map<String, String> headers}) async {
    headers ??= {};
    headers['Cache-Control'] ??= 'no-cache';
    headers['Content-Type'] ??= 'application/x-www-form-urlencoded';
    headers['Accept'] ??= '*/*';
    headers['Accept-Encoding'] ??= 'gzip, deflate, br';
    headers['Connection'] ??= 'keep-alive';

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    }
  }

  Future<dynamic> _postJson(Uri uri,
      {Map<String, String> headers, body}) async {
    headers ??= {};
    headers['Cache-Control'] ??= 'no-cache';
    headers['Content-Type'] ??= 'application/x-www-form-urlencoded';
    headers['Accept'] ??= '*/*';
    headers['Accept-Encoding'] ??= 'gzip, deflate, br';
    headers['Connection'] ??= 'keep-alive';

    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    }
  }

  //! User

  Future<User> logIn({String uEmail, String password}) async {
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

    if (_answer['auth']) {
      String _token = _answer['token'];
      token = _token;
      cacheController.writeKey(AUTH_CACHE_KEY, _token);

      User _user = User.fromJson(_answer['user']);
      return _user;
    } else {
      return null;
    }
  }

  Future<bool> register({User user}) async {
    Uri url = Uri.https(baseUrl, 'signup');

    Map _bodyMap = User.toJson(user);
    // String _body = jsonEncoder.convert(_bodyMap);

    dynamic _answer = await _postJson(
      url,
      body: _bodyMap,
    );

    if (_answer['auth']) {
      String _token = _answer['token'];
      token = _token;
      cacheController.writeKey(AUTH_CACHE_KEY, _token);

      return true;
    } else {
      return false;
    }
  }

  //! Project

  Future<List<Project>> getProjects(
      {bool isFavorited = false, String uEmail, int compId}) async {
    // Uri url = isFavorited
    //     ? Uri.https(baseUrl, 'project/favorited', {})
    //     : Uri.https(baseUrl, 'project', {});

    // dynamic json = await _getJson(url);
    // return json.map<Project>((item) => Project.fromJson(item)).toList();
    print('token: $token');

    final list1 = List.generate(
        3,
        (int index) => Project(
            pId: index,
            name: 'Name$index',
            description: 'Description$index',
            uEmail: 'uEmail$index@gmail.com'));
    final list2 = List.generate(
        9,
        (int index) => Project(
            pId: index,
            name: 'Name$index',
            description: 'Description$index',
            uEmail: 'uEmail$index@gmail.com'));

    return isFavorited
        ? Future.delayed(
            Duration(seconds: 2),
            () => list1,
          )
        : Future.delayed(
            Duration(seconds: 2),
            () => list2,
          );
  }

  Future<Project> createProject(
      {String name, String description, int compId}) async {
    // Uri url = Uri.https(baseApiUrl, 'project');

    // Map _bodyMap = {
    //   'name': name,
    //   'description': description,
    //   'comp_id': compId,
    // };

    // dynamic _answer = await _postJson(
    //   url,
    //   body: _bodyMap,
    // );

    return await Future.delayed(
      Duration(seconds: 2),
      () => Project(
          pId: 123,
          name: name,
          description: description,
          uEmail: 'temporary@smth.net'),
    );
    // if (_answer['auth']) {
    //   Project _project = Project.fromJson(_answer['project']);
    //   return _project;
    // } else {
    //   return null;
    // }
  }

  dynamic editProject() async {}

  dynamic deleteProject() async {}

  //! Task

  Future<List<Task>> getTasks() async {
    final list = List.generate(
        9,
        (int index) => Task(
            taskId: index,
            name: 'Name$index',
            description: 'Description$index',
            dueDate: 'DueDate$index',
            mId: index,
            colId: index % 2,
            uEmail: 'uEmail$index@gmail.com'));

    return Future.delayed(
      Duration(seconds: 2),
      () => list,
    );
  }

  dynamic createTask() async {}

  dynamic editTask() async {}

  dynamic deleteTask() async {}

  //! Column

  dynamic createColumn() async {}

  dynamic editColumn() async {}

  dynamic deleteColumn() async {}

  //! Company

  Future<List<Company>> getAllCompanies() async {
    Uri url = Uri.https(baseUrl, 'api/company');

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _getJson(
      url,
      headers: headers,
    );
    return _answer.map((item) => Company.fromJson(item)).toList();
  }

  Future<bool> createCompany(String name) async {
    Uri url = Uri.https(baseUrl, 'api/company');

    Map<String, String> headers = {
      'x-api-key': token,
    };

    Map _bodyMap = {
      'name': name
    };

    dynamic _answer = await _postJson(
      url,
      headers: headers,
      body: _bodyMap,
    );
    
    if (_answer['message'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

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
