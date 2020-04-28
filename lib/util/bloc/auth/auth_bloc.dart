import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/column.dart' as c;
import 'package:tempokit/model/task.dart';

import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

import 'package:tempokit/util/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;

  AuthBloc({this.repository}) : assert(repository != null);

  Future<void> generateStartupData({User user}) async {
    Company company = await repository.createCompany(name: 'My Workspace');
    repository.selectCompany(company: company);

    Project project = await repository.createProject(
      name: 'Example Project',
      description: 'This is your example project',
      compId: company.compId,
    );

    c.Column todo =
        await repository.createColumn(name: 'To Do', pId: project.pId);

    c.Column doing =
        await repository.createColumn(name: 'Doing', pId: project.pId);

    c.Column done =
        await repository.createColumn(name: 'Done', pId: project.pId);

    await repository.createTask(
      task: Task(
        name: 'Instagram promotions',
        description: 'Buy ads in instagram',
        colId: todo.colId,
      ),
    );

    await repository.createTask(
      task: Task(
        name: 'Ads design',
        description: 'Design a banner ad',
        colId: doing.colId,
      ),
    );

    await repository.createTask(
      task: Task(
        name: 'Pay money to designer',
        description: 'Use visa card to pay designer',
        colId: done.colId,
      ),
    );
  }

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      print('AppStarted');
      User _user;
      Company company;

      try {
        _user = await repository.initial();

        try {
          company = await repository.getCurrentCompany();
        } on CacheException {
          company = (await repository.getAllCompanies())[0];
        }

        repository.selectCompany(company: company);
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
            Routes.wrapperPage, (Route<dynamic> route) => false);
        yield Authenticated(user: _user);
      } on CacheException {
        // nothing
      }
    }

    if (event is LoginAttempt) {
      print('LoginAttempt');
      yield Loading();
      try {
        User _user = await repository.logIn(
            uEmail: event.uEmail, password: event.password);

        _user ?? (() => throw WrongCredentialsException())();

        Company company = (await repository.getAllCompanies())[0];
        repository.selectCompany(company: company);

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
          await generateStartupData(user: event.user);

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
