import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:tempokit/view/account/account_page.dart';
import 'package:tempokit/view/auth/initial_page.dart';
import 'package:tempokit/view/auth/sign_in_page.dart';
import 'package:tempokit/view/auth/sign_up_page.dart';
import 'package:tempokit/view/home/home_page.dart';
import 'package:tempokit/view/inbox/inbox_page.dart';
import 'package:tempokit/view/my_tasks/my_tasks_page.dart';
import 'package:tempokit/view/search/search_page.dart';
import 'package:tempokit/view/widgets/debug_widget.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  InitialPage initialPage;
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    durationInMilliseconds: 300)
  SignInPage signInPage;
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    durationInMilliseconds: 300)
  SignUpPage signUpPage;
  HomePage homePage;
  MyTasksPage myTasksPage;
  InboxPage inboxPage;
  SearchPage searchPage;
  AccountPage accountPage;
  DebugWidget debugWidget;
}