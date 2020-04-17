import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/utility_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
              child: Text('Dispatch'),
              onPressed: () {
                BlocProvider.of<UtilityBloc>(context).add(NetworkErrorEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
