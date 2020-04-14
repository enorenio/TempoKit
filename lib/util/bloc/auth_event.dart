part of 'auth_bloc.dart';

abstract class AuthEvent {
  AuthEvent([List props = const []]);
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted event';
}

class LoginAttempt extends AuthEvent {
  final String email;
  final String password;

  LoginAttempt({this.email, this.password});

  @override
  String toString() => 'LoginAttempt event';
}

class LogoutAttempt extends AuthEvent {
  @override
  String toString() => 'LogoutAttempt event';
}

class RegistrationAttempt extends AuthEvent {
  final User user;

  RegistrationAttempt({this.user});

  @override
  String toString() => 'RegistrationAttempt event';
}
