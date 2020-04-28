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

enum method { get, post, put, delete }

class ApiClient {
  final http.Client client;
  final JsonEncoder jsonEncoder = JsonEncoder();
  String token;

  ApiClient({this.client});

  final String baseUrl = 'tempokit.azurewebsites.net';

  Future<dynamic> _send(method m, Uri uri,
      {Map<String, String> headers, body}) async {
    headers ??= {};
    headers['Cache-Control'] ??= 'no-cache';
    headers['Content-Type'] ??= 'application/x-www-form-urlencoded';
    headers['Accept'] ??= '*/*';
    headers['Accept-Encoding'] ??= 'gzip, deflate, br';
    headers['Connection'] ??= 'keep-alive';

    http.Response response;
    switch (m) {
      case method.get:
        response = await http.get(uri, headers: headers);
        break;
      case method.post:
        response = await http.post(uri, headers: headers, body: body);
        break;
      case method.put:
        response = await http.put(uri, headers: headers, body: body);
        break;
      case method.delete:
        response = await http.delete(uri, headers: headers);
        break;
    }

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    }
  }

  //! Auth ------------------------------------------------------------------------------------------------------------

  Future<dynamic> logIn({String uEmail, String password}) async {
    Uri url = Uri.https(baseUrl, 'auth');

    Map _bodyMap = {
      'u_email': uEmail,
      'password': password,
    };

    dynamic _answer = await _send(
      method.post,
      url,
      body: _bodyMap,
    );

    if (_answer['auth']) {
      String _token = _answer['token'];

      User _user = User.fromJson(_answer['user']);
      return {'token': _token, 'user': _user};
    } else {
      return null;
    }
  }

  Future<String> register({User user}) async {
    Uri url = Uri.https(baseUrl, 'signup');

    Map _bodyMap = User.toJson(user);

    dynamic _answer = await _send(
      method.post,
      url,
      body: _bodyMap,
    );

    if (_answer['auth']) {
      String _token = _answer['token'];
      return _token;
    } else {
      return null;
    }
  }

  void saveToken({String token}) {
    this.token = token;
  }

  //! User ---------------------------------------------------------------------------------------------------------------

  Future<List<User>> getUsers({int compId}) async {
    Map<String, String> queryParams = {'comp_id': compId.toString()};

    Uri url = Uri.https(baseUrl, 'api/user', queryParams);

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _send(
      method.get,
      url,
      headers: headers,
    );

    return _answer.map<User>((item) => User.fromJson(item)).toList();
  }

  //! Project ------------------------------------------------------------------------------------------------------------

  Future<List<Project>> getProjects({bool isFavorited, int compId}) async {
    Map<String, String> queryParams = {'comp_id': compId.toString()};

    if (isFavorited != null) {
      queryParams['favorite'] = isFavorited ? '1' : '0';
    }

    Uri url = Uri.https(baseUrl, 'api/project', queryParams);

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _send(
      method.get,
      url,
      headers: headers,
    );

    return _answer.map<Project>((item) => Project.fromJson(item)).toList();
  }

  Future<Project> createProject(
      {String name, String description, int compId}) async {
    Uri url = Uri.https(baseUrl, 'api/project');

    Map<String, String> headers = {
      'x-api-key': token,
    };

    Map _bodyMap = {
      'name': name,
      'description': description,
      'comp_id': compId.toString(), //TODO: delete this cast
    };

    dynamic _answer = await _send(
      method.post,
      url,
      headers: headers,
      body: _bodyMap,
    );
    //TODO: delete next line
    _answer['comp_id'] = int.parse(_answer['comp_id']);
    Project _project = Project.fromJson(_answer);
    return _project;
  }

  dynamic editProject() async {}

  dynamic deleteProject() async {}

  //! Task ------------------------------------------------------------------------------------------------------------

  Future<dynamic> getColumnsAndTasks({int pId}) async {
    Map<String, String> queryParams = {'p_id': pId.toString()};

    Uri url = Uri.https(baseUrl, 'api/task', queryParams);

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _send(
      method.get,
      url,
      headers: headers,
    );

    List<dynamic> _ret;

    _ret = _answer.map((column) {
      Column _col = Column.fromJson(column);
      List<Task> tasks =
          column['tasks'].map<Task>((task) => Task.fromJson(task)).toList();
      return {'column': _col, 'tasks': tasks};
    }).toList();

    return _ret;
  }

  Future<Task> createTask({Task task, List<User> assignees}) async {
    Uri url = Uri.https(baseUrl, 'api/task');

    Map<String, String> headers = {
      'x-api-key': token,
      'Content-Type': 'application/json',
    };

    Map _bodyMap = {
      'name': task.name,
      'description': task.description,
      'due_date': task.dueDate,
      'col_id': task.colId,
      // 'assignees': assignees.map<String>((item) => item.uEmail).toList(),
    };

    String _json = JsonEncoder().convert(_bodyMap);

    dynamic _answer = await _send(
      method.post,
      url,
      headers: headers,
      body: _json,
    );

    // List<User> _assignees =
    //     _answer['assignees'].map<User>((item) => User(uEmail: item)).toList();
    // _answer['assignees'] = _assignees;
    return Task.fromJson(_answer);
  }

  dynamic editTask() async {}

  dynamic deleteTask() async {}

  Future<List<Task>> getMyTasks() async {
    Uri url = Uri.https(baseUrl, 'api/task/my');

    Map<String, String> headers = {
      'x-api-key': token,
    };

    dynamic _answer = await _send(
      method.get,
      url,
      headers: headers,
    );

    return _answer.map<Task>((item) => Task.fromJson(item)).toList();
  }

  dynamic assignTask() async {}

  //! Column ------------------------------------------------------------------------------------------------------------

  Future<List<Column>> getColumns({int pId}) async {
    Map<String, String> queryParams = {'p_id': pId.toString()};

    Uri url = Uri.https(baseUrl, 'api/column', queryParams);

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _send(
      method.get,
      url,
      headers: headers,
    );

    return _answer.map<Column>((item) => Column.fromJson(item)).toList();
  }

  Future<Column> createColumn({String name, int pId}) async {
    Uri url = Uri.https(baseUrl, 'api/column');

    Map<String, String> headers = {
      'x-api-key': token,
      'Content-Type': 'application/json',
    };

    Map _bodyMap = {'name': name, 'p_id': pId};

    String _json = JsonEncoder().convert(_bodyMap);

    dynamic _answer = await _send(
      method.post,
      url,
      headers: headers,
      body: _json,
    );

    Column _column = Column.fromJson(_answer);
    return _column;
  }

  dynamic editColumn() async {}

  dynamic deleteColumn() async {}

  //! Company ------------------------------------------------------------------------------------------------------------

  Future<List<Company>> getAllCompanies() async {
    Uri url = Uri.https(baseUrl, 'api/company');

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _send(
      method.get,
      url,
      headers: headers,
    );
    return _answer.map<Company>((item) => Company.fromJson(item)).toList();
  }

  Future<Company> createCompany({String name}) async {
    Uri url = Uri.https(baseUrl, 'api/company');

    Map<String, String> headers = {
      'x-api-key': token,
    };

    Map _bodyMap = {'name': name};

    dynamic _answer = await _send(
      method.post,
      url,
      headers: headers,
      body: _bodyMap,
    );

    Company _company = Company.fromJson(_answer);
    return _company;
  }

  //! Tag ------------------------------------------------------------------------------------------------------------

  dynamic getAllTags() async {}

  dynamic createTag() async {}

  dynamic editTag() async {}

  dynamic deleteTag() async {}

  //! Comment ------------------------------------------------------------------------------------------------------------

  Future<List<Comment>> getAllComments({int taskId}) async {
    Map<String, String> queryParams = {'task_id': taskId.toString()};

    Uri url = Uri.https(baseUrl, 'api/comment', queryParams);

    Map<String, String> headers = {
      'x-api-key': token,
    };

    List<dynamic> _answer = await _send(
      method.get,
      url,
      headers: headers,
    );

    return _answer.map<Comment>((item) => Comment.fromJson(item)).toList();
  }

  Future<Comment> createComment({String text, int taskId}) async {
    Uri url = Uri.https(baseUrl, 'api/comment');

    Map<String, String> headers = {
      'x-api-key': token,
      'Content-Type': 'application/json',
    };

    Map _bodyMap = {'text': text, 'task_id': taskId};

    String _json = JsonEncoder().convert(_bodyMap);

    dynamic _answer = await _send(
      method.post,
      url,
      headers: headers,
      body: _json,
    );

    return Comment.fromJson(_answer);
  }

  dynamic editComment() async {}

  dynamic deleteComment() async {}

  //! File ------------------------------------------------------------------------------------------------------------

  dynamic getAllFiles() async {}

  dynamic uploadFile() async {}

  dynamic deleteFile() async {}

  //! Milestone ------------------------------------------------------------------------------------------------------------

  dynamic getAllMilestones() async {}

  dynamic createMilestone() async {}

  dynamic editMilestone() async {}

  dynamic deleteMilestone() async {}

  //! Report ------------------------------------------------------------------------------------------------------------

  dynamic getReports() async {}

  dynamic createReport() async {}

  //! Search ------------------------------------------------------------------------------------------------------------

  dynamic search() async {}
}
