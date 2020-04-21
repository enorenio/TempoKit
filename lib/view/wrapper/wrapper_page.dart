import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/utility_bloc.dart';
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
    null,
    AppBar(
      title: const Text('Inbox'),
    ),
    null,
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
        .pushReplacementNamed(_routes.elementAt(_selectedIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarOptions.elementAt(_selectedIndex),
      body: BlocListener<UtilityBloc, UtilityState>(
        listener: UtilityBloc.listener,
        child: ExtendedNavigator<SubRouter>(
            router: SubRouter(), initialRoute: Routes.homePage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(60, 60, 60, 1),
        // iconSize: 20.0,
        selectedLabelStyle: Theme.of(context).textTheme.overline,
        unselectedLabelStyle: Theme.of(context).textTheme.caption,
        type: BottomNavigationBarType.shifting,
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
        //selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).accentColor,
      ),
    );
  }
}
