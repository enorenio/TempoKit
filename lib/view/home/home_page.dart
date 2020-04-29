import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tempokit/view/home/new_project.dart';
import 'package:tempokit/view/home/tabs/all_tab.dart';
import 'package:tempokit/view/home/tabs/favourites_tab.dart';
import 'package:tempokit/view/home/tabs/recents_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewProject(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              height: 50.0,
              child: new TabBar(
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Recents'),
                  Tab(text: 'Favourites'),
                ],
                labelColor: Colors.grey,
                indicatorColor: Colors.amber[800],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AllTab(),
              RecentsTab(),
              FavouritesTab(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToSecondScreen(context);
        },
        child: Icon(Icons.assignment),
        backgroundColor: Colors.amber[800],
      ),
    );
  }
}
