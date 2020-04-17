import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:tempokit/util/network/network_info.dart';

import 'bloc/utility_bloc.dart';

class Repository {
  final ApiClient apiClient;
  final NetworkInfo networkInfo;

  Repository({this.apiClient, this.networkInfo});

  //! User

  Future<User> logIn({String uEmail, String password}) async {
    if (await networkInfo.isConnected) {
      final answer = await apiClient.logIn();
      return answer;
    } else {
      return null;
    }
  }

  //! Project

  Future<List<Project>> getProjects(
      {bool isFavorited, String uEmail, int compId}) async {
    if (await networkInfo.isConnected) {
      final remoteProjects = await apiClient.getProjects(
          isFavorited: isFavorited ?? false, uEmail: uEmail, compId: compId);
      //.. save cache
      return remoteProjects;
    } else {
      // get cache
      return null;
    }
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
