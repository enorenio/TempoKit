import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:tempokit/model/column.dart' as c;
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/tag.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/repository.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;

  double _progress = 0;
  double get progress {
    return _progress += 1 / 21;
  }

  set progress(double value) => _progress = value;

  AuthBloc({this.repository}) : assert(repository != null);

  Stream<AuthState> generateStartupData({User user}) async* {
    Company company = await repository.createCompany(name: 'My Workspace');
    repository.selectCompany(company: company);

    yield ProgressLoading(progress: progress);

    Project project = await repository.createProject(
      name: 'Example Project',
      description: 'This is your example project',
      compId: company.compId,
    );

    yield ProgressLoading(progress: progress);

    c.Column todo =
        await repository.createColumn(name: 'To Do', pId: project.pId);

    yield ProgressLoading(progress: progress);

    c.Column doing =
        await repository.createColumn(name: 'Doing', pId: project.pId);

    yield ProgressLoading(progress: progress);

    c.Column done =
        await repository.createColumn(name: 'Done', pId: project.pId);

    yield ProgressLoading(progress: progress);

    await repository.createTask(
      task: Task(
        name: 'Instagram promotions',
        description: 'Buy ads in instagram',
        colId: todo.colId,
        dueDate: '2020-05-04'
      ),
    );

    yield ProgressLoading(progress: progress);

    Task task1 = await repository.createTask(
      task: Task(
        name: 'Facebook promotions',
        description: 'Buy ads in facebook',
        colId: todo.colId,
        dueDate: '2020-05-08'
      ),
    );

    yield ProgressLoading(progress: progress);

    await repository.createTask(
      task: Task(
        name: 'Ads design',
        description: 'Design a banner ad',
        colId: doing.colId,
        dueDate: '2020-05-23'
      ),
    );

    yield ProgressLoading(progress: progress);

    Task task2 = await repository.createTask(
      task: Task(
        name: 'Finish the project README',
        description: 'Add the version of framework',
        colId: doing.colId,
        dueDate: '2020-06-09'
      ),
    );

    yield ProgressLoading(progress: progress);

    await repository.createTask(
      task: Task(
        name: 'Pay money to designer',
        description: 'Use visa card to pay designer',
        colId: done.colId,
        dueDate: '2020-06-24'
      ),
    );

    yield ProgressLoading(progress: progress);

    Task task3 = await repository.createTask(
      task: Task(
        name: 'Add license to project',
        description: 'Choose MIT or GPL-3.0',
        colId: done.colId,
        dueDate: '2020-07-01'
      ),
    );

    yield ProgressLoading(progress: progress);

    await repository.assignTask(task: task1, assignees: [user]);

    yield ProgressLoading(progress: progress);

    await repository.assignTask(task: task2, assignees: [user]);

    yield ProgressLoading(progress: progress);

    await repository.assignTask(task: task3, assignees: [user]);

    yield ProgressLoading(progress: progress);

    Tag tag1 = await repository.createTag(
        project: project,
        tag: Tag(
          name: 'UI',
          color: '388E3C',
        ));

    yield ProgressLoading(progress: progress);

    Tag tag2 = await repository.createTag(
        project: project,
        tag: Tag(
          name: 'Design',
          color: '1976D2',
        ));

    yield ProgressLoading(progress: progress);

    Tag tag3 = await repository.createTag(
        project: project,
        tag: Tag(
          name: 'Monetization',
          color: '512DA8',
        ));

    yield ProgressLoading(progress: progress);

    Tag tag4 = await repository.createTag(
        project: project,
        tag: Tag(
          name: 'Bug',
          color: 'FF5252',
        ));

    yield ProgressLoading(progress: progress);

    await repository.assignTag(task: task1, tags: [tag2, tag3]);

    yield ProgressLoading(progress: progress);

    await repository.assignTag(task: task2, tags: [tag1, tag2]);

    yield ProgressLoading(progress: progress);

    await repository.assignTag(task: task3, tags: [tag4]);

    yield ProgressLoading(progress: progress);

    progress = 0;

    ExtendedNavigator.ofRouter<GlobalRouter>().pushNamedAndRemoveUntil(
        Routes.wrapperPage, (Route<dynamic> route) => false);
    yield Authenticated(user: user);
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
          repository.selectCompany(company: company);
        } on CacheException {
          List<Company> companies = await repository.getAllCompanies();
          if (companies.length > 0) {
            company = companies[0];
            repository.selectCompany(company: company);
          }
        }

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
      // yield Loading();

      try {
        bool _result = await repository.register(user: event.user);

        if (_result) {
          yield* generateStartupData(user: event.user);
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
