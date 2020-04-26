import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/project.dart';

import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

import 'package:tempokit/util/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repository;

  HomeBloc({this.repository}) : assert(repository != null);

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetProjectsEvent) {
      try {
        Company _company = await repository.getCurrentCompany();
        List<Project> _projects =
            await repository.getProjects(compId: _company.compId);
        yield DefaultHomeState(projects: _projects);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }
  }
}
