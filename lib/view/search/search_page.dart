import 'package:flutter/material.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:tempokit/util/errors.dart';

import 'package:tempokit/view/widgets/loading_widget.dart';

List<String> list = ['1','2','3','4','5'];


class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, top: 40, right: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  print(value);
                },
                controller: inputController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    labelText: "Search",
                    //hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)))),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color.fromRGBO(60, 60, 60, 1),
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: ListTile(
                    leading: Icon(Icons.assignment,size: 40,color: Colors.amber[800],),
                    title: Text(list[index]),
                    subtitle: Text(list[index]),
                    onTap: () {}
                ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}

