part of 'account_bloc.dart';

abstract class AccountEvent {}

class SelectCompany extends AccountEvent {
  final Company company;

  SelectCompany({this.company});

  @override
  String toString() => 'SelectCompany event';
}
