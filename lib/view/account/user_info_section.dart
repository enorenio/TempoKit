import 'package:flutter/material.dart';

import 'package:tempokit/util/bloc/auth/auth_bloc.dart';

class UserInfoSection extends StatefulWidget {
  final Authenticated userState;

  UserInfoSection({Key key, this.userState}) : super(key: key);

  @override
  _UserInfoSectionState createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.yellow],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(13, 51, 32, 0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Text(
              widget.userState.user.fullName[0],
              style: TextStyle(color: Colors.white, fontSize: 32.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              widget.userState.user.fullName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30.0),
            child: Text(
              widget.userState.user.workType+' Guru',
              style: TextStyle(fontSize: 16.0,),
            ),
          ),
        ],
      ),
    );
  }
}
