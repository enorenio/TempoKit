import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/model/user.dart';

import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

import 'package:tempokit/util/repository.dart';

part 'my_tasks_event.dart';
part 'my_tasks_state.dart';

class MyTasksBloc extends Bloc<MyTasksEvent, MyTasksState> {
  final Repository repository;

  MyTasksBloc({this.repository}) : assert(repository != null);

  @override
  MyTasksState get initialState => Loading();

  @override
  Stream<MyTasksState> mapEventToState(MyTasksEvent event) async* {
    if (event is GetMyTasksEvent) {
      try {
        List<Task> myTasks = await repository.getMyTasks();
        yield TasksState(tasks: myTasks);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is GetUsersEvent) {
      try {
        Company _company = await repository.getCurrentCompany();
        List<User> users = await repository.getUsers(compId: _company.compId);
        yield UsersState(users: users);
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

    if (event is CreateTaskEvent) {
      try {
        await repository.createTask(task: event.task);

        List<Task> myTasks = await repository.getMyTasks();
        yield TasksState(tasks: myTasks);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is CreateCommentEvent) {
      try {
        await repository.createComment(text: event.text, taskId: event.taskId);

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
