import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({Key key}) : super(key: key);

  final Type className = DebugPage;

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