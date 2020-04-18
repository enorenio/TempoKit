import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:tempokit/model/user.dart';
import '../../util/bloc/auth_bloc.dart';

import '../auth/sign_up_page.dart';
import '../auth/sign_in_page.dart';
import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';
import 'package:auto_route/auto_route.dart';

import 'package:loading/loading.dart' as loader;
/*class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$this',
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      ),
    );
  }
}
*/

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  bool switchControl = false;
  var textHolder = 'OFF';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'ON';
      });
    } else {
      setState(() {
        switchControl = false;
        textHolder = 'OFF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (state is AuthError) {
        showError(context, state);
      } else if (state is AuthError) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: state.error.title,
              content: state.error.content,
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
            barrierDismissible: true,
          );
        });
      }
      if (state is Authenticated) {
        return Scaffold(
          body: SafeArea(
              child: //_state.user.fullName!='\0' ?
                  SingleChildScrollView(
                      child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: <Widget>[
                Center(
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
                          state.user.fullName[0],
                          //'?',
                          style: TextStyle(color: Colors.white, fontSize: 32.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          state.user.fullName,
                          //'Full Name',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromRGBO(60, 60, 60, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(13, 51, 32, 0.1),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Organizations',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                state.user.workType,
                                //'Org Name',

                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                //'Email',
                                state.user.uEmail,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromRGBO(60, 60, 60, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(13, 51, 32, 0.1),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 10.0, bottom: 10.0),
                                  child: Text(
                                    //'Email',
                                    '$textHolder',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, bottom: 10.0),
                                    child: Switch(
                                      onChanged: toggleSwitch,
                                      value: switchControl,
                                      activeColor: Colors.amberAccent,
                                      activeTrackColor: Colors.deepOrangeAccent,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                    )),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromRGBO(60, 60, 60, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(13, 51, 32, 0.1),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Contact Support',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                '@https://t.me/tempokit_bot',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromRGBO(60, 60, 60, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(13, 51, 32, 0.1),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'More',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                'Rate the App',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                'Version 0.0.1',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: MediaQuery.of(context).size.width * .9,
                  height: 50,
                  child: LogoutButton(),
                ),
              ],
            ),
          ))),
        );
      }
      return tempWidget;
    });
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Color.fromRGBO(60, 60, 60, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        BlocProvider.of<AuthBloc>(context).add(LogoutAttempt());
      },
      child: Text(
        'LOG OUT',
        style: TextStyle(
            color: Colors.amber[800],
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
