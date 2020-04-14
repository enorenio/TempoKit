import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:tempokit/view/account/account_page.dart';
import 'package:tempokit/view/home/home_page.dart';
import 'package:tempokit/view/inbox/inbox_page.dart';
import 'package:tempokit/view/my_tasks/my_tasks_page.dart';
import 'package:tempokit/view/search/search_page.dart';

@CustomAutoRouter(
  transitionsBuilder: TransitionsBuilders.fadeIn
)
class $SubRouter {
  @initial
  HomePage homePage;
  MyTasksPage myTasksPage;
  InboxPage inboxPage;
  SearchPage searchPage;
  AccountPage accountPage;
}
