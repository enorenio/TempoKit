import 'package:flutter/material.dart';

const DEBUG = true;

ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],
  accentColor: Colors.cyan[600],
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.normal),
    body1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),
  ),
);
