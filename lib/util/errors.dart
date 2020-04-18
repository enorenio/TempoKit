import 'package:flutter/material.dart';

class IError {
  Widget title;
  Widget content;

  IError({
    this.title,
    this.content,
  });
}

class AnyServerError {
  int statusCode;
  String reasonPhrase;

  AnyServerError({
    this.statusCode,
    this.reasonPhrase,
  });
}

class InternalNetworkError {
  String title;

  InternalNetworkError({
    this.title,
  });
}
