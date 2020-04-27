part of 'my_tasks_bloc.dart';

abstract class MyTasksEvent {
  MyTasksEvent([List props = const []]);
}

class GetMyTasksEvent extends MyTasksEvent {}

class GetUsersEvent extends MyTasksEvent {}

class GetCommentsEvent extends MyTasksEvent {
  final int taskId;

  GetCommentsEvent({this.taskId});
}

class CreateCommentEvent extends MyTasksEvent {
  final String text;
  final int taskId;

  CreateCommentEvent({this.text, this.taskId});
}
