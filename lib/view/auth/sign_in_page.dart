import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/util/bloc/auth/auth_bloc.dart';
import 'package:tempokit/util/consts.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  TapGestureRecognizer _signUpTapRecognizer;
  final _loginFormKey = GlobalKey<FormState>();

  Map<String, String> _formData = {};

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signUpTapRecognizer = TapGestureRecognizer()..onTap = _handleSignUpTap;
  }

  _handleSignUpTap() {
    ExtendedNavigator.ofRouter<GlobalRouter>()
        .pushReplacementNamed(Routes.signUpPage);
  }

  bool isEmailAddressValid(String email) {
    RegExp exp = new RegExp(
      r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$",
      caseSensitive: false,
      multiLine: false,
    );
    return exp.hasMatch(email.trim());
    // we trim to remove trailing white spaces
  }

/*bool isPasswordValid(String password) {
    RegExp exp = new RegExp (
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})",  на всякий случай, но сейчас пароль хотя бы в 4 символа
        caseSensitive: false,
        multiLine: false,
    );
    return exp.hasMatch(password);
}*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (state is AuthError) {
        showError(context, state);
      }
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            customBorder: CircleBorder(),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Color.fromRGBO(90, 97, 117, 1),
              iconSize: 30,
              onPressed: () {
                ExtendedNavigator.ofRouter<GlobalRouter>()
                    .pushReplacementNamed(Routes.initialPage);
              },
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Hey! ",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Is that you?",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('Email'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your email!';
                            if (isEmailAddressValid(value) == false)
                              return 'Incorrect email address. Try again!';
                            return null;
                          },
                          controller: _emailController,
                          onSaved: (value) => _formData['email'] = value,
                          cursorColor: Color(0xFF3C4858),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'It\'s your email',
                            suffixIcon: Icon(Icons.alternate_email),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('Password'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your passsword!';
                            if (value.length < 4)
                              return 'Length of your password must be at least 4 symbols!';
                            return null;
                          },
                          controller: _passwordController,
                          onSaved: (value) => _formData['password'] = value,
                          cursorColor: Color(0xFF3C4858),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Our little secret',
                            suffixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 60,
                        margin: EdgeInsets.only(top: 40, bottom: 30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF3C4858).withOpacity(.4),
                              offset: Offset(10.0, 10.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              gradient: orangeToYellow,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 40.0),
                                    child: Text(
                                      'Let\'s go',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(context).accentColor,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            final form = _loginFormKey.currentState;
                            if (form.validate()) {
                              form.save();
                              _handleSignIn();
                            }
                          },
                        ),
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.body1,
                            children: [
                              TextSpan(
                                text: 'First time here? ',
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                                recognizer: _signUpTapRecognizer,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    });
  }

  void _handleSignIn() async {
    BlocProvider.of<AuthBloc>(context).add(LoginAttempt(
        uEmail: _emailController.text, password: _passwordController.text));
  }

  @override
  void dispose() {
    _signUpTapRecognizer.dispose();

    super.dispose();
  }
}
