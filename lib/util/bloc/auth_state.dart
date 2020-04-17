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

class AuthError extends AuthState {
  IError error;
}

class NetworkError extends AuthError {
  IError error;

  NetworkError({this.error});
}

class WrongCredentialsError extends AuthError {
  IError error;

  WrongCredentialsError({this.error});
}
