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

  //! User ------------------------------------------------------------------------------------------------------------

  Future<dynamic> initial() async {
    String _answer = await cacheController.readKey(USER_CACHE_KEY);

    String _token = await cacheController.readKey(AUTH_CACHE_KEY);
    apiClient.initial(token: _token);

    Map _jsonMap = json.decode(_answer);
    User _user = User.fromJson(_jsonMap);

    return _user;
    // return User.fromString(_answer);
  }

  Future<User> logIn({String uEmail, String password}) async {
    if (await networkInfo.isConnected) {
      password = _encrypter.encrypt(password, iv: _iv).base64;

      User _user = await apiClient.logIn(uEmail: uEmail, password: password);

      cacheController.writeKey(USER_CACHE_KEY, _user.toString());

      return _user;
    } else {
      throw NetworkException(title: 'Login Error');
    }
  }

  Future<bool> register({User user}) async {
    if (await networkInfo.isConnected) {
      user..password = _encrypter.encrypt(user.password, iv: _iv).base64;
      bool _answer = await apiClient.register(user: user);

      if (_answer) {
        user..password = '';
        cacheController.writeKey(USER_CACHE_KEY, user.toString());
      }

      return _answer;
    } else {
      throw NetworkException(title: 'Register Error');
    }
  }

  void logout() {
    cacheController.deleteKey(AUTH_CACHE_KEY);
    cacheController.deleteKey(USER_CACHE_KEY);
  }

  //! Project ------------------------------------------------------------------------------------------------------------

  Future<List<Project>> getProjects({bool isFavorited, int compId}) async {
    if (await networkInfo.isConnected) {
      Company _company = await getCurrentCompany();
      List<Project> _remoteProjects = await apiClient.getProjects(
          isFavorited: isFavorited, compId: _company.compId);

      if (_remoteProjects != []) {
        // cache project list ???
      }

      return _remoteProjects;
    } else {
      throw NetworkException(title: 'Network Error');
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
      throw NetworkException(title: 'Network Error');
    }
  }

  dynamic editProject() async {}

  dynamic deleteProject() async {}

  //! Task ------------------------------------------------------------------------------------------------------------

  Future<List<Task>> getTasks() async {
    if (await networkInfo.isConnected) {
      List<Task> _remoteTasks = await apiClient.getTasks();

      if (_remoteTasks != []) {
        // cache task list ???
      }

      return _remoteTasks;
    } else {
      throw NetworkException(title: 'Network Error');
    }
  }

  dynamic createTask() async {}

  dynamic editTask() async {}

  dynamic deleteTask() async {}

  //! Column ------------------------------------------------------------------------------------------------------------

  dynamic createColumn() async {}

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
    Map _jsonMap = json.decode(_string);
    Company _company = Company.fromJson(_jsonMap);
    return _company;
    // return Company.fromString(_company);
  }

  //! Tag ------------------------------------------------------------------------------------------------------------

  dynamic getAllTags() async {}

  dynamic createTag() async {}

  dynamic editTag() async {}

  dynamic deleteTag() async {}

  //! Comment ------------------------------------------------------------------------------------------------------------

  dynamic getAllComments() async {}

  dynamic createComment() async {}

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
