part of 'account_bloc.dart';

abstract class AccountState {}

class CompanyState extends AccountState {
  final Company company;

  CompanyState({this.company});
}
