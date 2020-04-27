part of 'my_tasks_bloc.dart';

abstract class MyTasksEvent {
  MyTasksEvent([List props = const[]]);
}

class GetMyTasksEvent extends MyTasksEvent {}

class GetUsersEvent extends MyTasksEvent {}