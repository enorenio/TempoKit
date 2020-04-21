import 'package:flutter/material.dart';

const DEBUG = false;

const AUTH_CACHE_KEY = 'Auth_key';
const USER_CACHE_KEY = 'User_key';

ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  accentColor: Colors.amber[800],
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    display4: TextStyle(),
    display3: TextStyle(),
    display2: TextStyle(),
    display1: TextStyle(),
    headline: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
    title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
    subhead: TextStyle(),
    subtitle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
    body1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
    body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
    button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
    caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Segoe UI'),
    overline: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Segoe UI'),
  ),
);
