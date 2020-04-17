part of 'utility_bloc.dart';

abstract class UtilityState {
  UtilityState([List props = const <dynamic>[]]);
}

class DefaultState extends UtilityState {}

class NetworkErrorState extends UtilityState {
  final String message;

  NetworkErrorState({this.message});
}
