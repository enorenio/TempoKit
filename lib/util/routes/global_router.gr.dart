// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tempokit/view/auth/initial_page.dart';
import 'package:tempokit/view/auth/sign_in_page.dart';
import 'package:tempokit/view/auth/sign_up_page.dart';
import 'package:tempokit/view/wrapper/wrapper_page.dart';
import 'package:tempokit/view/error_page.dart';
import 'package:tempokit/view/debug_page.dart';

abstract class Routes {
  static const initialPage = '/';
  static const signInPage = '/sign-in-page';
  static const signUpPage = '/sign-up-page';
  static const wrapperPage = '/wrapper-page';
  static const errorPage = '/error-page';
  static const debugPage = '/debug-page';
}

class GlobalRouter extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<GlobalRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.initialPage:
        if (hasInvalidArgs<InitialPageArguments>(args)) {
          return misTypedArgsRoute<InitialPageArguments>(args);
        }
        final typedArgs =
            args as InitialPageArguments ?? InitialPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => InitialPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signInPage:
        if (hasInvalidArgs<SignInPageArguments>(args)) {
          return misTypedArgsRoute<SignInPageArguments>(args);
        }
        final typedArgs = args as SignInPageArguments ?? SignInPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignInPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signUpPage:
        if (hasInvalidArgs<SignUpPageArguments>(args)) {
          return misTypedArgsRoute<SignUpPageArguments>(args);
        }
        final typedArgs = args as SignUpPageArguments ?? SignUpPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignUpPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.wrapperPage:
        if (hasInvalidArgs<WrapperPageArguments>(args)) {
          return misTypedArgsRoute<WrapperPageArguments>(args);
        }
        final typedArgs =
            args as WrapperPageArguments ?? WrapperPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => WrapperPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.errorPage:
        if (hasInvalidArgs<ErrorPageArguments>(args)) {
          return misTypedArgsRoute<ErrorPageArguments>(args);
        }
        final typedArgs = args as ErrorPageArguments ?? ErrorPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ErrorPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.debugPage:
        if (hasInvalidArgs<DebugPageArguments>(args)) {
          return misTypedArgsRoute<DebugPageArguments>(args);
        }
        final typedArgs = args as DebugPageArguments ?? DebugPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => DebugPage(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//InitialPage arguments holder class
class InitialPageArguments {
  final Key key;
  InitialPageArguments({this.key});
}

//SignInPage arguments holder class
class SignInPageArguments {
  final Key key;
  SignInPageArguments({this.key});
}

//SignUpPage arguments holder class
class SignUpPageArguments {
  final Key key;
  SignUpPageArguments({this.key});
}

//WrapperPage arguments holder class
class WrapperPageArguments {
  final Key key;
  WrapperPageArguments({this.key});
}

//ErrorPage arguments holder class
class ErrorPageArguments {
  final Key key;
  ErrorPageArguments({this.key});
}

//DebugPage arguments holder class
class DebugPageArguments {
  final Key key;
  DebugPageArguments({this.key});
}
