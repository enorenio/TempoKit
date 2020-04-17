import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/user.dart';
import '../../util/bloc/auth_bloc.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  TapGestureRecognizer _signInTapRecognizer;
  final _loginFormKey = GlobalKey<FormState>();

  Map<String, String> _formData = {};

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _workTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signInTapRecognizer = TapGestureRecognizer()..onTap = _handleSignInTap;
  }

  _handleSignInTap() {
    ExtendedNavigator.ofRouter<GlobalRouter>()
        .pushReplacementNamed(Routes.signInPage);
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Loading) {
          return loadingWidget;
        } else if (state is AuthError) {
          showError(context, state);
        }
        return Scaffold(
          //backgroundColor: Colors.black12,
          appBar: AppBar(
            brightness: Brightness.light,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            //backgroundColor: Colors.white,
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
                                "Let us",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 1.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 40.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "get to know you",
                                style: TextStyle(
                                  fontSize: 20,
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
                          child: Text('Full Name'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter your name!';
                            },
                            controller: _nameController,
                            onSaved: (value) => _formData['name'] = value,
                            cursorColor: Color(0xFF3C4858),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintText: 'Your First and Last names',
                                suffixIcon: Icon(Icons.account_circle)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('Job Type'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter your job type!';
                            },
                            controller: _workTypeController,
                            onSaved: (value) => _formData['workType'] = value,
                            cursorColor: Color(0xFF3C4858),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintText: 'What do you do?',
                                suffixIcon: Icon(Icons.business_center)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('Email'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter your email!';
                              if (isEmailAddressValid(value) == false)
                                return 'Incorrect email address. Try again!';
                            },
                            controller: _emailController,
                            onSaved: (value) => _formData['email'] = value,
                            cursorColor: Color(0xFF3C4858),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintText: 'It\'s your email',
                                suffixIcon: Icon(Icons.alternate_email)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('Password'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter your passsword!';
                              if (value.length < 4)
                                return 'Length of your password must be at least 4 symbols!';
                            },
                            controller: _passwordController,
                            onSaved: (value) => _formData['password'] = value,
                            cursorColor: Color(0xFF3C4858),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintText: 'Our litte secret',
                                suffixIcon: Icon(Icons.lock_outline)),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 60,
                          margin: EdgeInsets.only(top: 30, bottom: 30.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF3C4858).withOpacity(.4),
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: RaisedButton(
                            padding: EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.deepOrange, Colors.yellow],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      //decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepOrange, Colors.yellow]),),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 40.0),

                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xFF3C4858),
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
                                _handleSignUp();
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
                                  text: 'Already have an account? ',
                                ),
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Color(0xC0C0C0C0)),
                                    recognizer: _signInTapRecognizer),
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  void _handleSignUp() async {
    BlocProvider.of<AuthBloc>(context).add(RegistrationAttempt(
      user: User(
        uEmail: _emailController.text,
        fullName: _nameController.text,
        password: _passwordController.text,
        workType: _workTypeController.text,
      ),
    ));
  }

  @override
  void dispose() {
    _signInTapRecognizer.dispose();

    super.dispose();
  }
}
