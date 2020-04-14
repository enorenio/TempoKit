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
import 'package:tempokit/view/home/home_page.dart';
import 'package:tempokit/view/my_tasks/my_tasks_page.dart';
import 'package:tempokit/view/inbox/inbox_page.dart';
import 'package:tempokit/view/search/search_page.dart';
import 'package:tempokit/view/account/account_page.dart';
import 'package:tempokit/view/widgets/debug_widget.dart';

abstract class Routes {
  static const initialPage = '/';
  static const signInPage = '/sign-in-page';
  static const signUpPage = '/sign-up-page';
  static const homePage = '/home-page';
  static const myTasksPage = '/my-tasks-page';
  static const inboxPage = '/inbox-page';
  static const searchPage = '/search-page';
  static const accountPage = '/account-page';
  static const debugWidget = '/debug-widget';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

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
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SignInPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          transitionDuration: const Duration(milliseconds: 300),
        );
      case Routes.signUpPage:
        if (hasInvalidArgs<SignUpPageArguments>(args)) {
          return misTypedArgsRoute<SignUpPageArguments>(args);
        }
        final typedArgs = args as SignUpPageArguments ?? SignUpPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SignUpPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          transitionDuration: const Duration(milliseconds: 300),
        );
      case Routes.homePage:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.myTasksPage:
        if (hasInvalidArgs<MyTasksPageArguments>(args)) {
          return misTypedArgsRoute<MyTasksPageArguments>(args);
        }
        final typedArgs =
            args as MyTasksPageArguments ?? MyTasksPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => MyTasksPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.inboxPage:
        if (hasInvalidArgs<InboxPageArguments>(args)) {
          return misTypedArgsRoute<InboxPageArguments>(args);
        }
        final typedArgs = args as InboxPageArguments ?? InboxPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => InboxPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.searchPage:
        if (hasInvalidArgs<SearchPageArguments>(args)) {
          return misTypedArgsRoute<SearchPageArguments>(args);
        }
        final typedArgs = args as SearchPageArguments ?? SearchPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SearchPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.accountPage:
        if (hasInvalidArgs<AccountPageArguments>(args)) {
          return misTypedArgsRoute<AccountPageArguments>(args);
        }
        final typedArgs =
            args as AccountPageArguments ?? AccountPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => AccountPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.debugWidget:
        if (hasInvalidArgs<DebugWidgetArguments>(args)) {
          return misTypedArgsRoute<DebugWidgetArguments>(args);
        }
        final typedArgs =
            args as DebugWidgetArguments ?? DebugWidgetArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => DebugWidget(key: typedArgs.key),
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

//HomePage arguments holder class
class HomePageArguments {
  final Key key;
  HomePageArguments({this.key});
}

//MyTasksPage arguments holder class
class MyTasksPageArguments {
  final Key key;
  MyTasksPageArguments({this.key});
}

//InboxPage arguments holder class
class InboxPageArguments {
  final Key key;
  InboxPageArguments({this.key});
}

//SearchPage arguments holder class
class SearchPageArguments {
  final Key key;
  SearchPageArguments({this.key});
}

//AccountPage arguments holder class
class AccountPageArguments {
  final Key key;
  AccountPageArguments({this.key});
}

//DebugWidget arguments holder class
class DebugWidgetArguments {
  final Key key;
  DebugWidgetArguments({this.key});
}
