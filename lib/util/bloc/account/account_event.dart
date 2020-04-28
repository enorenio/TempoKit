part of 'account_bloc.dart';

abstract class AccountEvent {}

class SelectCompany extends AccountEvent {
  final List<Company> companies;
  final Company selected;

  SelectCompany({this.companies, this.selected});

  @override
  String toString() => 'SelectCompany event';
}

class GetCompanies extends AccountEvent {}

class CreateCompany extends AccountEvent {
  final Company company;
  final List<User> assignees;

  CreateCompany({this.company, this.assignees});

  @override
  String toString() => 'CreateCompany event';
}
