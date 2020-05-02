import 'package:flutter/material.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/util/errors.dart';

import 'package:tempokit/view/widgets/loading_widget.dart';

List<String> list = [
  'Task',
  'Promotion',
  'Ads',
  'Valorant',
  'League of Legends'
];
List<String> description = [
  'Your tasks are here',
  'No promotion sorry',
  'Full screen banners for 10 min',
  'Dont know what is it',
  'Teemo mainer'
];

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
            Container(
              height: 50,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          inputController.clear();
                        })),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                ),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return searchCard(list[index], description[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ListTile searchCard(String title, String desc) => ListTile(
  //     contentPadding: EdgeInsets.all(0),
  //     leading: Icon(
  //       Icons.check_circle_outline,
  //       size: 40,
  //       color: Colors.amber[800],
  //     ),
  //     title: Text(title),
  //     subtitle: Text(desc),
  //     onTap: () {
  //       print("Maladec");
  //     });

  Container searchCard(String title, String desc) => Container(
        height: 50,
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check_circle_outline,
                size: 35,
                color: Colors.amber[800],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                  children: <Widget>[Text(title), Text(desc)],
                  crossAxisAlignment: CrossAxisAlignment.start)
            ],
          ),
          onTap: (){
            print("AAA");
          },
        ),
      );
}
