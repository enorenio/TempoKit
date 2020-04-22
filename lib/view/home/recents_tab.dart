import 'package:flutter/material.dart';

class RecentsTab extends StatefulWidget {
  const RecentsTab({Key key}) : super(key: key);

  @override
  _RecentsTabState createState() => _RecentsTabState();
}

class _RecentsTabState extends State<RecentsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${this.widget}'),
    );
  }
}