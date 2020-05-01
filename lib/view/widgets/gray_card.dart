import 'package:flutter/material.dart';

class GrayCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  GrayCard({Key key, this.child, this.padding, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
            margin: margin ??
                EdgeInsets.only(
                  bottom: 20.0,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromRGBO(0, 0, 0, 0.3),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(13, 51, 32, 0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: this.child,
          ),
        ),
      ],
    );
  }
}
