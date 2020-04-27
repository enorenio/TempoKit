part of 'home_bloc.dart';

abstract class HomeEvent {
  HomeEvent([List props = const[]]);
}

class GetProjectsEvent extends HomeEvent {
  final bool isFavorite;

  GetProjectsEvent({this.isFavorite});

  @override
  String toString() => 'GetProjects event';
}

class GetTasksEvent extends HomeEvent {}

class CreateProjectEvent extends HomeEvent {
  final Project project;

  CreateProjectEvent({this.project});

  @override
  String toString() => 'Create project event';
}

