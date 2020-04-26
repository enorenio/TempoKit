import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/util/repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final Repository repository;

  AccountBloc({this.repository}) : assert(repository != null);
  @override
  AccountState get initialState => CompanyState(company: null);

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is SelectCompany) {
      print('SelectCompany');
      repository.selectCompany(company: event.company);
      yield CompanyState(company: event.company);
    }
  }
}
