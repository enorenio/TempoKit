import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/auth_bloc.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$this',
              style: Theme.of(context).textTheme.title,
            ),
            RaisedButton(
              onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                  LoginAttempt(
                      uEmail: 'morshnev.aleksey@gmail.com', password: '12345')),
              child: Text('LOG IN', style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}
