part of 'home_bloc.dart';

abstract class HomeState {
  HomeState([List props = const <dynamic>[]]);
}

class ProjectsState extends HomeState {
  final List<Project> projects;

  ProjectsState({this.projects});
}

class ColumnsAndTasksState extends HomeState {
  final dynamic columnsAndTasks;

  ColumnsAndTasksState({this.columnsAndTasks});
}

class Loading extends HomeState {}

class HomeError extends HomeState implements GeneralState {
  IError error;
}

class ServerError extends HomeError {
  IError error;

  ServerError({ServerException internalError}) {
    error = IError(
      title: Text(internalError.reasonPhrase),
      content: Text(
          'Code: ${internalError.statusCode}: ${internalError.reasonPhrase}'),
    );
  }
}

class NetworkError extends HomeError {
  IError error;

  NetworkError({NetworkException internalError}) {
    error = IError(
      title: Text(internalError.title),
      content: Text('The Internet connection appears to be offline.'),
    );
  }
}

class CacheError extends HomeError {
  IError error;

  CacheError() {
    error = IError(
      title: Text('Cache Error'),
      content: Text('Your cache is corrupted.'),
    );
  }
}
