part of 'inbox_bloc.dart';

abstract class InboxEvent {
  InboxEvent([List props = const []]);
}

class GetMyTasksEvent extends InboxEvent {}

class CreateCommentEvent extends InboxEvent {
  final Comment comment;
  final int taskId;

  CreateCommentEvent({this.comment, this.taskId});
}
