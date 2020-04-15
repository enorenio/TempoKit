import 'package:flutter/material.dart';

const DEBUG = false;

ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],
  accentColor: Colors.cyan[600],
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    display4: TextStyle(),
    display3: TextStyle(),
    display2: TextStyle(),
    display1: TextStyle(),
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
    title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
    subhead: TextStyle(),
    body2: TextStyle(),
    body1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, fontFamily: 'Nunito'),
    caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Segoe UI'),
    button: TextStyle(),
    subtitle: TextStyle(),
    overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: 'Segoe UI'),
  ),
);
