import 'package:flutter/material.dart';
import 'package:tempokit/util/repository.dart';
import 'package:tempokit/view/home/project_page.dart';

import '../../injection_container.dart';

class AllTab extends StatefulWidget {
  const AllTab({Key key}) : super(key: key);

  @override
  _AllTabState createState() => _AllTabState();
}
class _AllTabState extends State<AllTab> {
  @override
  int _itemCount=5;
  Widget build(BuildContext context) {
    return Container(
      // this is temporary, just to test, you can delete it if you want to
      // i wrote it so you now see how to get data
      // i dont know but we will probably change FutureBuilder to StreamBuilder
      // so that newly created project could be reactively updated to list
      child: FutureBuilder(
        future: sl<Repository>().getProjects(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
              return Wrap(
                children: <Widget>[LinearProgressIndicator()],
              );
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].description),
                  onTap: ()=>_navigateToProject(context,index),
                ),
              );
          }
        },
      ),
    );
  }
}

void _navigateToProject(BuildContext context, index) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectPage(index: index),
      ));
}


 