import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/column.dart' as c;
import 'package:tempokit/model/task.dart';

import 'package:tempokit/util/errors.dart';

import 'package:tempokit/util/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repository;
  Project project;

  HomeBloc({this.repository}) : assert(repository != null);

  Future<List<dynamic>> processData(List<dynamic> data) async {
    return (await Future.wait(data.map((columnAndTasks) async {
      c.Column column = columnAndTasks['column'];
      List<Task> tasks = columnAndTasks['tasks'];
      dynamic comments = await Future.wait(tasks.map((task) async {
        int _numberOfComments =
            (await repository.getAllComments(taskId: task.taskId)).length;
        return {
          'task_id': task.taskId,
          'number_of_comments': _numberOfComments,
        };
      }).toList());
      return {
        'column': column,
        'tasks': tasks,
        'comments': comments,
      };
    })))
        .toList();
  }

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SelectProjectEvent) {
      project = event.project;
    }

    if (event is GetProjectsEvent) {
      try {
        Company _company = await repository.getCurrentCompany();
        List<Project> _projects = await repository.getProjects(
          isFavorited: event.isFavorite,
          compId: _company.compId,
        );
        yield ProjectsState(projects: _projects);
      } on CacheException {
        yield ProjectsState(projects: []);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is GetColumnsAndTasksEvent) {
      try {
        List<dynamic> columnsAndTasks =
            await repository.getColumnsAndTasks(pId: project.pId);

        columnsAndTasks = await processData(columnsAndTasks);

        yield ColumnsAndTasksState(columnsAndTasks: columnsAndTasks);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is GetCommentsEvent) {
      try {
        List<Comment> _comments =
            await repository.getAllComments(taskId: event.taskId);

        yield CommentsState(comments: _comments);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is CreateProjectEvent) {
      try {
        Company _company = await repository.getCurrentCompany();
        await repository.createProject(
          name: event.project.name,
          description: event.project.description,
          compId: _company.compId,
        );
        List<Project> _projects =
            await repository.getProjects(compId: _company.compId);
        yield ProjectsState(projects: _projects);
      } on CacheException {
        yield ProjectsState(projects: []);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is CreateColumnEvent) {
      try {
        await repository.createColumn(
            pId: project.pId, name: event.column.name);

        dynamic columnsAndTasks =
            await repository.getColumnsAndTasks(pId: project.pId);

        columnsAndTasks = await processData(columnsAndTasks);

        yield ColumnsAndTasksState(columnsAndTasks: columnsAndTasks);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is CreateTaskEvent) {
      try {
        await repository.createTask(task: event.task);

        dynamic columnsAndTasks =
            await repository.getColumnsAndTasks(pId: project.pId);

        columnsAndTasks = await processData(columnsAndTasks);

        yield ColumnsAndTasksState(columnsAndTasks: columnsAndTasks);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is CreateCommentEvent) {
      try {
        await repository.createComment(
            text: event.comment.text, taskId: event.taskId);

        List<Comment> comments =
            await repository.getAllComments(taskId: event.taskId);
        yield CommentsState(comments: comments);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }
  }
}
