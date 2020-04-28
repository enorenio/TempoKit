part of 'home_bloc.dart';

abstract class HomeEvent {
  HomeEvent([List props = const []]);
}

class GetProjectsEvent extends HomeEvent {
  final bool isFavorite;

  GetProjectsEvent({this.isFavorite});

  @override
  String toString() => 'GetProjects event';
}

class GetColumnsAndTasksEvent extends HomeEvent {
  final Project project;

  GetColumnsAndTasksEvent({this.project});
}

class CreateProjectEvent extends HomeEvent {
  final Project project;

  CreateProjectEvent({this.project});

  @override
  String toString() => 'Create project event';
}

class CreateColumnEvent extends HomeEvent {
  final Project project;
  final c.Column column;

  CreateColumnEvent({this.project, this.column});
}

class CreateTaskEvent extends HomeEvent {
  final Project project;
  final Task task;

  CreateTaskEvent({this.project, this.task});
}
