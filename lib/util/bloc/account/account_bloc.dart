import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final Repository repository;

  AccountBloc({this.repository}) : assert(repository != null);
  @override
  AccountState get initialState => SelectedCompanyState(company: null);

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is SelectCompany) {
      print('SelectCompany');
      repository.selectCompany(company: event.selected);
      yield CompaniesState(companies: event.companies, current: event.selected);
    }

    if (event is GetCompanies) {
      try {
        List<Company> companies = await repository.getAllCompanies();
        Company current = await repository.getCurrentCompany();
        yield CompaniesState(companies: companies, current: current);
      } on CacheException {
        yield CompaniesState(companies: [], current: null);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }

    if (event is CreateCompany) {
      try {
        Company company =
            await repository.createCompany(name: event.company.name);
        repository.selectCompany(company: company);
        //TODO: add users to company
        List<Company> companies = await repository.getAllCompanies();
        yield CompaniesState(companies: companies, current: company);
      } on NetworkException catch (exception) {
        yield NetworkError(internalError: exception);
      } on ServerException catch (exception) {
        yield ServerError(internalError: exception);
      }
    }
  }
}
