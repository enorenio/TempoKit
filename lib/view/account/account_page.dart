import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/bloc/account/account_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';
import '../../util/bloc/auth/auth_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(((GetCompanies())));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, userState) {
      if (userState is Loading) {
        print('$this loading');
        return Center(child: CircularProgressIndicator());
      } else if (userState is AuthError) {
        showError(context, userState);
      }
      if (userState is Authenticated) {
        return BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
          if (state is AccountError) {
            showError(context, state);
          }
          if (state is CompaniesState) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
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
                                margin:
                                    EdgeInsets.only(top: 10.0, bottom: 20.0),
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
                                  userState.user.fullName[0],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 30.0),
                                child: Text(
                                  userState.user.fullName,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyCont(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _myTitle('Organizations'),
                              // Center(
                              //   child: ListView.builder(
                              //       itemCount: state.companies.length,
                              //       itemBuilder: (context, index) {
                              //         Company _current = state.companies[index];
                              //         return ListTile(
                              //           title: _myText(
                              //               state.companies[index].name),
                              //           onTap: () {
                              //             print(
                              //                 '${_current.compId} - ${_current.name} - ${_current.uEmail}');
                              //           },
                              //         );
                              //       }),
                              // ),
                            ],
                          ),
                        ),
                        MyCont(
                          child: Notification(),
                        ),
                        MyCont(
                          child: Contact(),
                        ),
                        MyCont(
                          child: More(),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: MediaQuery.of(context).size.width * .9,
                          height: 50,
                          child: LogoutButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return tempWidget;
        });
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

class MyCont extends StatelessWidget {
  final Widget child;

  MyCont({this.child});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
            child: this.child,
          ),
        ),
      ],
    );
  }
}

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _myTitle('Notifications'),
          Container(
              child: Row(children: <Widget>[
            _myText(textHolder),
            Container(
                margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Switch(
                  onChanged: toggleSwitch,
                  value: switchControl,
                  activeColor: Colors.amberAccent,
                  activeTrackColor: Colors.deepOrangeAccent,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                )),
          ]))
        ]);
  }
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _myTitle('Contact Support'),
        _myText('@https://t.me/tempokit_bot'),
      ],
    );
  }
}

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _myTitle('More'),
        _myText('Rate Us'),
        _myText('Privacy Security'),
        _myText('Version 0.0.1')
      ],
    );
  }
}

_myText(text) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    ),
  );
}

_myTitle(title) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    child: Text(
      title,
      style: TextStyle(
          color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
  );
}
