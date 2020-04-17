import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

import '../repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;

  AuthBloc({this.repository}) : assert(repository != null);

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield Uninitialized();
    }

    yield Loading();

    if (event is LoginAttempt) {
      print('LoginAttempt');
      User _user = await repository.logIn();

      if (_user == null) {
        yield NetworkError(
          error: IError(
            title: Text('Login Error'),
            content: Text('The Internet connection appears to be offline.'),
          ),
        );
      } else if (event.uEmail == _user.uEmail &&
          event.password == _user.password) {
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _user);
      } else {
        yield WrongCredentialsError(
          error: IError(
            title: Text('Login Error'),
            content: Text('User does not exist'),
          ),
        );
      }
    }

    if (event is LogoutAttempt) {
      print('LogoutAttempt');
      ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
          Routes.initialPage, (Route<dynamic> route) => false);
      yield Uninitialized();
    }

    if (event is RegistrationAttempt) {
      print('RegistrationAttempt');
      // check with api call
      // return either authenticated or error
      bool noError = true;

      if (noError) {
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: event.user);
      } else {
        //... error showing
        // yield Error();
      }
    }
  }
}
