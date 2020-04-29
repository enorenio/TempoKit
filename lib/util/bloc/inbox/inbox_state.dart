part of 'inbox_bloc.dart';

abstract class InboxState {
  InboxState([List props = const <dynamic>[]]);
}

class TasksState extends InboxState {
  final List<Task> tasks;

  TasksState({this.tasks});
}

class CommentsState extends InboxState {
  final List<Comment> comments;

  CommentsState({this.comments});
}

class Loading extends InboxState {}

class InboxError extends InboxState implements GeneralState {
  IError error;
}

class ServerError extends InboxError {
  IError error;

  ServerError({ServerException internalError}) {
    error = IError(
      title: Text(internalError.reasonPhrase),
      content: Text(
          'Code: ${internalError.statusCode}: ${internalError.reasonPhrase}'),
    );
  }
}

class NetworkError extends InboxError {
  IError error;

  NetworkError({NetworkException internalError}) {
    error = IError(
      title: Text(internalError.title),
      content: Text('The Internet connection appears to be offline.'),
    );
  }
}

class CacheError extends InboxError {
  IError error;

  CacheError() {
    error = IError(
      title: Text('Cache Error'),
      content: Text('Your cache is corrupted.'),
    );
  }
}
