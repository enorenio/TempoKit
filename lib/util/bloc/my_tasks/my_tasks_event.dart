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

class CreateTaskEvent extends MyTasksEvent {
  final Task task;

  CreateTaskEvent({this.task});
}

class CreateCommentEvent extends MyTasksEvent {
  final Comment comment;
  final int taskId;

  CreateCommentEvent({this.comment, this.taskId});
}
