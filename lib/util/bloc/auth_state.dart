part of 'auth_bloc.dart';

abstract class AuthState {
  AuthState([List props = const <dynamic>[]]);
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated({this.user});
}

class Loading extends AuthState {}

class Error extends AuthState {
  final String message;

  Error({this.message});
}