import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tempokit/util/routes/sub_router.gr.dart';

class WrapperPage extends StatefulWidget {
  WrapperPage({Key key}) : super(key: key);

  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _selectedIndex = 0;

  static List<AppBar> _appBarOptions = [
    AppBar(
      title: const Text('Home'),
    ),
    AppBar(
      title: const Text('asd1'),
    ),
    AppBar(
      title: const Text('Inbox'),
    ),
    AppBar(
      title: const Text('asd2'),
    ),
    AppBar(
      title: const Text('Account'),
    ),
  ];

  static List<String> _routes = [
    Routes.homePage,
    Routes.myTasksPage,
    Routes.inboxPage,
    Routes.searchPage,
    Routes.accountPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    ExtendedNavigator.ofRouter<SubRouter>()
        .pushNamed(_routes.elementAt(_selectedIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarOptions.elementAt(_selectedIndex),
      body: ExtendedNavigator<SubRouter>(
          router: SubRouter(), initialRoute: Routes.homePage),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            title: Text('My Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Inbox'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
