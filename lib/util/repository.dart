import 'dart:convert';

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
import 'package:tempokit/util/api_client.dart';
import 'package:tempokit/util/cache_controller.dart';
import 'package:tempokit/util/consts.dart';
import 'package:tempokit/util/network/network_info.dart';
import 'package:encrypt/encrypt.dart';

import 'errors.dart';

class Repository {
  final ApiClient apiClient;
  final NetworkInfo networkInfo;
  final CacheController cacheController;
  static final Key _key = Key.fromUtf8('moy_modniy_klu4ik_dlinoy_32_bita');
  static final IV _iv = IV.fromLength(16);
  static final Encrypter _encrypter = Encrypter(AES(_key));
  final JsonEncoder jsonEncoder = JsonEncoder();

  Repository({this.apiClient, this.networkInfo, this.cacheController});

  //! Auth ------------------------------------------------------------------------------------------------------------

  Future<User> initial() async {
    String _answer = await cacheController.readKey(USER_CACHE_KEY);

    String _token = await cacheController.readKey(AUTH_CACHE_KEY);
    apiClient.saveToken(token: _token);

    return User.fromString(_answer);
  }

  Future<User> logIn({String uEmail, String password}) async {
    if (await networkInfo.isConnected) {
      password = _encrypter.encrypt(password, iv: _iv).base64;

      dynamic _answer =
          await apiClient.logIn(uEmail: uEmail, password: password);
      User _user = _answer['user'];
      String _token = _answer['token'];

      cacheController.writeKey(USER_CACHE_KEY, _user.toString());
      cacheController.writeKey(AUTH_CACHE_KEY, _token);
      apiClient.saveToken(token: _token);

      return _user;
    } else {
      throw NetworkException(title: 'Login Error');
    }
  }

  Future<bool> register({User user}) async {
    if (await networkInfo.isConnected) {
      user..password = _encrypter.encrypt(user.password, iv: _iv).base64;
      String _answer = await apiClient.register(user: user);

      if (_answer != null) {
        user..password = '';

        cacheController.writeKey(USER_CACHE_KEY, user.toString());
        cacheController.writeKey(AUTH_CACHE_KEY, _answer);
        apiClient.saveToken(token: _answer);

        return true;
      }

      return false;
    } else {
      throw NetworkException(title: 'Register Error');
    }
  }

  void logout() {
    cacheController.deleteKey(AUTH_CACHE_KEY);
    cacheController.deleteKey(USER_CACHE_KEY);
    cacheController.deleteKey(CUR_COMP_CACHE_KEY);
  }

  Future<User> getCurrentUser() async {
    String _string = await cacheController.readKey(USER_CACHE_KEY);
    return User.fromString(_string);
  }

  //! User ------------------------------------------------------------------------------------------------------------

  Future<List<User>> getUsers({int compId}) async {
    if (await networkInfo.isConnected) {
      List<User> _answer = await apiClient.getUsers(compId: compId);

      return _answer;
    } else {
      throw NetworkException();
    }
  }

  //! Project ------------------------------------------------------------------------------------------------------------

  Future<List<Project>> getProjects({bool isFavorited, int compId}) async {
    if (await networkInfo.isConnected) {
      List<Project> _remoteProjects =
          await apiClient.getProjects(isFavorited: isFavorited, compId: compId);

      if (_remoteProjects != []) {
        // cache project list ???
      }

      return _remoteProjects;
    } else {
      throw NetworkException();
    }
  }

  Future<Project> createProject(
      {String name, String description, int compId}) async {
    if (await networkInfo.isConnected) {
      Project _answer = await apiClient.createProject(
          name: name, description: description, compId: compId);

      if (_answer != null) {
        // cache to project list yes??
      }

      return _answer;
    } else {
      throw NetworkException();
    }
  }

  dynamic editProject() async {}

  dynamic deleteProject() async {}

  //! Task ------------------------------------------------------------------------------------------------------------

  Future<dynamic> getColumnsAndTasks({int pId}) async {
    if (await networkInfo.isConnected) {
      dynamic _remoteTasks = await apiClient.getColumnsAndTasks(pId: pId);

      if (_remoteTasks != []) {
        // cache task list ???
      }

      return _remoteTasks;
    } else {
      throw NetworkException();
    }
  }

  Future<Task> createTask({Task task}) async {
    if (await networkInfo.isConnected) {
      dynamic _answer = await apiClient.createTask(task: task);

      return _answer;
    } else {
      throw NetworkException();
    }
  }

  dynamic editTask() async {}

  dynamic deleteTask() async {}

  Future<List<Task>> getMyTasks() async {
    if (await networkInfo.isConnected) {
      List<Task> _answer = await apiClient.getMyTasks();
      return _answer;
    } else {
      throw NetworkException();
    }
  }

  dynamic assignTask() async {}

  //! Column ------------------------------------------------------------------------------------------------------------

  Future<List<Column>> getColumns({int pId}) async {
    if (await networkInfo.isConnected) {
      return await apiClient.getColumns(pId: pId);
    } else {
      throw NetworkException();
    }
  }

  Future<Column> createColumn({String name, int pId}) async {
    if (await networkInfo.isConnected) {
      Column answer = await apiClient.createColumn(name: name, pId: pId);
      return answer;
    } else {
      throw NetworkException();
    }
  }

  dynamic editColumn() async {}

  dynamic deleteColumn() async {}

  //! Company ------------------------------------------------------------------------------------------------------------

  Future<List<Company>> getAllCompanies() async {
    if (await networkInfo.isConnected) {
      return await apiClient.getAllCompanies();
    } else {
      throw NetworkException();
    }
  }

  Future<Company> createCompany({String name}) async {
    if (await networkInfo.isConnected) {
      Company answer = await apiClient.createCompany(name: name);

      return answer;
    } else {
      throw NetworkException();
    }
  }

  void selectCompany({Company company}) {
    cacheController.writeKey(CUR_COMP_CACHE_KEY, company.toString());
  }

  Future<Company> getCurrentCompany() async {
    String _string = await cacheController.readKey(CUR_COMP_CACHE_KEY);
    return Company.fromString(_string);
  }

  //! Tag ------------------------------------------------------------------------------------------------------------

  dynamic getAllTags() async {}

  dynamic createTag() async {}

  dynamic editTag() async {}

  dynamic deleteTag() async {}

  //! Comment ------------------------------------------------------------------------------------------------------------

  Future<List<Comment>> getAllComments({int taskId}) async {
    if (await networkInfo.isConnected) {
      List<Comment> comments = await apiClient.getAllComments(taskId: taskId);

      return comments;
    } else {
      throw NetworkException();
    }
  }

  Future<Comment> createComment({String text, int taskId}) async {
    if (await networkInfo.isConnected) {
      Comment comment =
          await apiClient.createComment(text: text, taskId: taskId);

      return comment;
    } else {
      throw NetworkException();
    }
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
