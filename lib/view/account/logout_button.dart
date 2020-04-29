import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/auth/auth_bloc.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Color.fromRGBO(60, 60, 60, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        BlocProvider.of<AuthBloc>(context).add(LogoutAttempt());
      },
      child: Text(
        'LOG OUT',
        style: TextStyle(
            color: Colors.amber[800],
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
