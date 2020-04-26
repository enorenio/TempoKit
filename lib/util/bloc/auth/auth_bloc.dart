import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart' as loader;
import 'package:tempokit/model/company.dart';

import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

import 'package:tempokit/util/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

Widget loadingWidget = Scaffold(
  body: Center(
    child: loader.Loading(
      indicator: BallSpinFadeLoaderIndicator(),
      size: 40.0,
    ),
  ),
);

//TODO: this is bad solution, find another one
Widget tempWidget = Scaffold();

showError(BuildContext context, AuthError state) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: state.error.title,
        content: state.error.content,
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  });
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;

  AuthBloc({this.repository}) : assert(repository != null);

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      print('AppStarted');
      try {
        User _user = await repository.initial();
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _user);
      } on CacheException {
        // we should not do that at all
        // yield CacheError();
      }
    }

    if (event is LoginAttempt) {
      print('LoginAttempt');
      yield Loading();
      try {
        User _user = await repository.logIn(
            uEmail: event.uEmail, password: event.password);
        
        _user ?? (() => throw WrongCredentialsException())();

        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);

        yield Authenticated(user: _user);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      } on WrongCredentialsException {
        yield WrongCredentialsError();
      }
    }

    if (event is LogoutAttempt) {
      print('LogoutAttempt');
      yield Loading();

      repository.logout();

      ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
          Routes.initialPage, (Route<dynamic> route) => false);
      yield Uninitialized();
    }

    if (event is RegistrationAttempt) {
      print('RegistrationAttempt');
      yield Loading();

      try {
        bool _result = await repository.register(user: event.user);

        if (_result) {
          Company company = await repository.createCompany(name: 'My Workspace');
          repository.selectCompany(company: company);
          ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
              Routes.wrapperPage, (Route<dynamic> route) => false);
          yield Authenticated(user: event.user);
        } else {
          throw WrongCredentialsException();
        }
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      } on WrongCredentialsException {
        yield WrongCredentialsError();
      }
    }
  }
}
