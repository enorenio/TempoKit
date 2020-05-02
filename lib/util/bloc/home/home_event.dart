part of 'home_bloc.dart';

abstract class HomeEvent {
  HomeEvent([List props = const []]);
}

class SelectProjectEvent extends HomeEvent {
  final Project project;

  SelectProjectEvent({this.project});
}

class GetProjectsEvent extends HomeEvent {
  final bool isFavorite;

  GetProjectsEvent({this.isFavorite});

  @override
  String toString() => 'GetProjects event';
}

class GetColumnsAndTasksEvent extends HomeEvent {}

class CreateProjectEvent extends HomeEvent {
  final Project project;

  CreateProjectEvent({this.project});

  @override
  String toString() => 'Create project event';
}

// class GetCommentsEvent extends HomeEvent {
//   final int taskId;

//   GetCommentsEvent({this.taskId});
// }

class GetTaskViewInfoEvent extends HomeEvent {
  final Task task;

  GetTaskViewInfoEvent({this.task});
}

class CreateColumnEvent extends HomeEvent {
  final c.Column column;

  CreateColumnEvent({this.column});
}

class CreateTaskEvent extends HomeEvent {
  final Task task;

  CreateTaskEvent({this.task});
}

class CreateCommentEvent extends HomeEvent {
  final Comment comment;
  final Task task;

  CreateCommentEvent({this.comment, this.task});
}