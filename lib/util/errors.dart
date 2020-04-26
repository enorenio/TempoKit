import 'package:flutter/material.dart';

class IError {
  Widget title;
  Widget content;

  IError({
    this.title,
    this.content,
  });
}

class ServerException implements Exception{
  int statusCode;
  String reasonPhrase;

  ServerException({
    this.statusCode,
    this.reasonPhrase,
  });
}

class NetworkException implements Exception {
  String title;

  NetworkException({
    this.title = 'Network Error',
  });
}

class CacheException implements Exception {}

class WrongCredentialsException implements Exception {}