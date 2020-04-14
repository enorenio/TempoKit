import 'package:auto_route/auto_route_annotations.dart';
import 'package:tempokit/view/auth/initial_page.dart';
import 'package:tempokit/view/auth/sign_in_page.dart';
import 'package:tempokit/view/auth/sign_up_page.dart';
import 'package:tempokit/view/debug_page.dart';
import 'package:tempokit/view/error_page.dart';
import 'package:tempokit/view/wrapper/wrapper_page.dart';

@MaterialAutoRouter()
class $GlobalRouter {
  @initial
  InitialPage initialPage;
  // @CustomRoute(
  //   transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  //   durationInMilliseconds: 300)
  SignInPage signInPage;
  // @CustomRoute(
  //   transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  //   durationInMilliseconds: 300)
  SignUpPage signUpPage;
  WrapperPage wrapperPage;
  ErrorPage errorPage;
  DebugPage debugPage;
}