import 'package:flutter/material.dart';

myText(text) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    ),
  );
}

myTitle(title) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    child: Text(
      title,
      style: TextStyle(
          color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
  );
}
