import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/auth_bloc.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AuthBloc>(context).add(AppStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 200.0),
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  Container(
                    width: 300,
                    height: 47,
                    margin: EdgeInsets.only(top: 200.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x21212121),
                            offset: Offset(10.0, 10.0),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: RaisedButton(
                      color: Color(0x21212121),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 1.2),
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => SignUpPage()),);
                        ExtendedNavigator.ofRouter<GlobalRouter>()
                            .pushNamed(Routes.signUpPage);
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 47,
                    margin: EdgeInsets.only(top: 20.0),
                    child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Color(0xFFC4C4C4), width: 1.2),
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => SignInPage()),);
                        ExtendedNavigator.ofRouter<GlobalRouter>()
                            .pushNamed(Routes.signInPage);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
