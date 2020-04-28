import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/view/home/favourites_tab.dart';
import 'package:tempokit/view/home/recents_tab.dart';
import 'all_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

void _navigateToSecondScreen(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _NewProject(),
      ));
}

class _HomePageState extends State<HomePage> {
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

class _NewProject extends StatelessWidget {
  final _projectNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter name!';
                      },
                      controller: _projectNameController,
                      //onSaved: (value) => _formData['email'] = value,
                      cursorColor: Color(0xFF3C4858),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Project Name',
                        //suffixIcon: Icon(Icons.alternate_email)
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      validator: (value) {},
                      controller: _descriptionController,
                      //onSaved: (value) => _formData['email'] = value,
                      cursorColor: Color(0xFF3C4858),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150,
                        child: RaisedButton(
                          color: Color.fromRGBO(60, 60, 60, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                            if (true) {
                              //TODO: change true to ...validate()
                              BlocProvider.of<HomeBloc>(context).add(
                                CreateProjectEvent(
                                  project: Project(
                                    name: _projectNameController.text,
                                    description: _descriptionController.text,
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150,
                        child: RaisedButton(
                          color: Color.fromRGBO(60, 60, 60, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
