import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // data and constructor

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield Uninitialized();
    } else {
      yield Loading();
    }

    if (event is LoginAttempt) {
      print('LoginAttempt');
      // check with api call
      // return either authenticated or error
      User _user = User(
        uEmail: 'morshnev.aleksey@gmail.com',
        fullName: 'Aleksey Morshnev',
        password: '12345',
        workType: 'dev',
      );

      if (event.uEmail == _user.uEmail && event.password == _user.password) {
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _user);
      } else {
        //... error showing
        // yield Error();
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
      User _user = User(
        uEmail: 'morshnev.aleksey@gmail.com',
        fullName: 'Aleksey Morshnev',
        password: '12345',
        workType: 'dev',
      );

      if (noError) {
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _user);
      } else {
        //... error showing
        // yield Error();
      }
    }
  }
}
