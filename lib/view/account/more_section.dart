import 'package:flutter/material.dart';
import 'package:tempokit/view/account/globals.dart';

class MoreSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        myTitle('More'),
        myText('Rate Us'),
        myText('Privacy Security'),
        myText('Version 0.0.1')
      ],
    );
  }
}