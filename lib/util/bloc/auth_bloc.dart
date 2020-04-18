import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart' as loader;

import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/cache_controller.dart';
import 'package:tempokit/util/consts.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

import '../repository.dart';

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
  final CacheController cacheController;

  AuthBloc({this.repository, this.cacheController})
      : assert(repository != null),
        assert(cacheController != null);

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      print('AppStarted');
      dynamic _answer = await cacheController.readKey(USER_CACHE_KEY);
      if (_answer is String) {
        Map _jsonMap = json.decode(_answer);
        User _user = User.fromJson(_jsonMap);
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _user);
      }
    }

    if (event is LoginAttempt) {
      print('LoginAttempt');
      yield Loading();
      dynamic _result = await repository.logIn(
          uEmail: event.uEmail, password: event.password);

      if (_result is InternalNetworkError) {
        yield NetworkError(internalError: _result);
      } else if (_result is AnyServerError) {
        yield ServerError(internalError: _result);
      } else if (_result is User) {
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _result);
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
      yield Loading();

      cacheController.deleteKey(AUTH_CACHE_KEY);
      cacheController.deleteKey(USER_CACHE_KEY);

      ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
          Routes.initialPage, (Route<dynamic> route) => false);
      yield Uninitialized();
    }

    if (event is RegistrationAttempt) {
      print('RegistrationAttempt');
      yield Loading();

      dynamic _result = await repository.register(user: event.user);
      //TODO: Change Strings to consts
      if (_result is InternalNetworkError) {
        yield NetworkError(internalError: _result);
      } else if (_result is AnyServerError) {
        yield ServerError(internalError: _result);
      } else if (_result) {
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: event.user);
      } else {
        yield WrongCredentialsError(
          error: IError(
            title: Text('Register Error'),
            content: Text('User already exists'),
          ),
        );
      }
    }
  }
}
