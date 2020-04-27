part of 'my_tasks_bloc.dart';

abstract class MyTasksState {
  MyTasksState([List props = const <dynamic>[]]);
}

class TasksState extends MyTasksState {
  final List<Task> tasks;

  TasksState({this.tasks});
}

class UsersState extends MyTasksState {
  final List<User> users;

  UsersState({this.users});
}

class CommentsState extends MyTasksState {
  final List<Comment> comments;

  CommentsState({this.comments});
}

class CommentState extends MyTasksState {
  final Comment comment;

  CommentState({this.comment});
}

class Loading extends MyTasksState {}

class MyTasksError extends MyTasksState implements GeneralState {
  IError error;
}

class ServerError extends MyTasksError {
  IError error;

  ServerError({ServerException internalError}) {
    error = IError(
      title: Text(internalError.reasonPhrase),
      content: Text(
          'Code: ${internalError.statusCode}: ${internalError.reasonPhrase}'),
    );
  }
}

class NetworkError extends MyTasksError {
  IError error;

  NetworkError({NetworkException internalError}) {
    error = IError(
      title: Text(internalError.title),
      content: Text('The Internet connection appears to be offline.'),
    );
  }
}

class CacheError extends MyTasksError {
  IError error;

  CacheError() {
    error = IError(
      title: Text('Cache Error'),
      content: Text('Your cache is corrupted.'),
    );
  }
}
