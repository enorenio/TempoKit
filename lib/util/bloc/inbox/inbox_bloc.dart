import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/task.dart';

import 'package:tempokit/util/errors.dart';

import 'package:tempokit/util/repository.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final Repository repository;

  InboxBloc({this.repository}) : assert(repository != null);

  @override
  InboxState get initialState => Loading();

  @override
  Stream<InboxState> mapEventToState(InboxEvent event) async* {
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

    if (event is GetByMeTasksEvent) {
      try {
        List<Task> byMeTasks = await repository.getByMeTasks();
        yield TasksState(tasks: byMeTasks);
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
