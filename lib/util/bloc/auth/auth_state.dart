part of 'auth_bloc.dart';

abstract class AuthState extends GeneralState {
  AuthState([List props = const <dynamic>[]]);
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated({this.user});
}

class Loading extends AuthState {}

class AuthError extends AuthState implements GeneralState{
  IError error;
}

class ServerError extends AuthError {
  IError error;

  ServerError({ServerException internalError}) {
    error = IError(
      title: Text(internalError.reasonPhrase),
      content: Text(
          'Code: ${internalError.statusCode}: ${internalError.reasonPhrase}'),
    );
  }
}

class NetworkError extends AuthError {
  IError error;

  NetworkError({NetworkException internalError}) {
    error = IError(
      title: Text(internalError.title),
      content: Text('The Internet connection appears to be offline.'),
    );
  }
}

class CacheError extends AuthError {
  IError error;

  CacheError() {
    error = IError(
      title: Text('Cache Error'),
      content: Text('Your cache is corrupted.'),
    );
  }
}

class WrongCredentialsError extends AuthError {
  IError error;

  WrongCredentialsError() {
    error = IError(
      title: Text('Auth Error'),
      content: Text('User does not exist or password is wrong.'),
    );
  }
}
