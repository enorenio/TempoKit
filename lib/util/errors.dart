import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class IError {
  Widget title;
  Widget content;

  IError({
    this.title,
    this.content,
  });
}

abstract class GeneralState {
  IError error;
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

showError(BuildContext context, GeneralState state) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: state.error.title,
        content: state.error.content,
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  });
}