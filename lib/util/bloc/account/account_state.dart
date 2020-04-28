part of 'account_bloc.dart';

abstract class AccountState {}

class SelectedCompanyState extends AccountState {
  final Company company;

  SelectedCompanyState({this.company});
}

class CompaniesState extends AccountState {
  final List<Company> companies;
  final Company current;

  CompaniesState({this.companies, this.current});
}

// class NewCompanyState extends AccountState {
//   final Company company;

//   NewCompanyState({this.company});
// }

// class Loading extends AccountState {}

class AccountError extends AccountState implements GeneralState {
  IError error;
}

class ServerError extends AccountError {
  IError error;

  ServerError({ServerException internalError}) {
    error = IError(
      title: Text(internalError.reasonPhrase),
      content: Text(
          'Code: ${internalError.statusCode}: ${internalError.reasonPhrase}'),
    );
  }
}

class NetworkError extends AccountError {
  IError error;

  NetworkError({NetworkException internalError}) {
    error = IError(
      title: Text(internalError.title),
      content: Text('The Internet connection appears to be offline.'),
    );
  }
}

class CacheError extends AccountError {
  IError error;

  CacheError() {
    error = IError(
      title: Text('Cache Error'),
      content: Text('Your cache is corrupted.'),
    );
  }
}

