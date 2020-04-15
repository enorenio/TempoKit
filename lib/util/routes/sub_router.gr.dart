// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tempokit/view/home/home_page.dart';
import 'package:tempokit/view/my_tasks/my_tasks_page.dart';
import 'package:tempokit/view/inbox/inbox_page.dart';
import 'package:tempokit/view/search/search_page.dart';
import 'package:tempokit/view/account/account_page.dart';

abstract class Routes {
  static const homePage = '/';
  static const myTasksPage = '/my-tasks-page';
  static const inboxPage = '/inbox-page';
  static const searchPage = '/search-page';
  static const accountPage = '/account-page';
}

class SubRouter extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<SubRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homePage:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              HomePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.myTasksPage:
        if (hasInvalidArgs<MyTasksPageArguments>(args)) {
          return misTypedArgsRoute<MyTasksPageArguments>(args);
        }
        final typedArgs =
            args as MyTasksPageArguments ?? MyTasksPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              MyTasksPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      case Routes.inboxPage:
        if (hasInvalidArgs<InboxPageArguments>(args)) {
          return misTypedArgsRoute<InboxPageArguments>(args);
        }
        final typedArgs = args as InboxPageArguments ?? InboxPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              InboxPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      case Routes.searchPage:
        if (hasInvalidArgs<SearchPageArguments>(args)) {
          return misTypedArgsRoute<SearchPageArguments>(args);
        }
        final typedArgs = args as SearchPageArguments ?? SearchPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SearchPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      case Routes.accountPage:
        if (hasInvalidArgs<AccountPageArguments>(args)) {
          return misTypedArgsRoute<AccountPageArguments>(args);
        }
        final typedArgs =
            args as AccountPageArguments ?? AccountPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AccountPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

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
