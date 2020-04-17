part of 'utility_bloc.dart';

abstract class UtilityEvent {
  UtilityEvent([List props = const []]);
}

class NetworkErrorEvent extends UtilityEvent {
  NetworkErrorEvent();

  @override
  String toString() => 'NetworkEror event';
}
