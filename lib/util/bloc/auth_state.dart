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

  NetworkError({InternalNetworkError internalError}) {
    error = IError(
      title: Text(internalError.title),
      content: Text('The Internet connection appears to be offline.'),
    );
  }
}

class ServerError extends AuthError {
  IError error;

  ServerError({AnyServerError internalError}) {
    error = IError(
      title: Text(internalError.reasonPhrase),
      content: Text(
          'Code: ${internalError.statusCode}: ${internalError.reasonPhrase}'),
    );
  }
}

class WrongCredentialsError extends AuthError {
  IError error;

  WrongCredentialsError({this.error});
}
