import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/auth_bloc.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key key}) : super(key: key);

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final Type className = DebugPage;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(
        LoginAttempt(uEmail: 'morshnev.aleksey@gmail.com', password: '12345'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(
            '$className',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );
  }
}
