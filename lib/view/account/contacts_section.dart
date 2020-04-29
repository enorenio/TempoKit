import 'package:flutter/material.dart';
import 'package:tempokit/view/account/globals.dart';

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        myTitle('Contact Support'),
        myText('@https://t.me/tempokit_bot'),
      ],
    );
  }
}
