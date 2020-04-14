import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key key}) : super(key: key);

  final Type className = InitialPage;

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
