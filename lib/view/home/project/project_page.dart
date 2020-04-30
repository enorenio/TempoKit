import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/model/project.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/view/home/project/column_carousel.dart';
import 'package:tempokit/view/home/project/new_column_view.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  ProjectPage({this.project});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.maybePop(context).then((_) =>
              BlocProvider.of<HomeBloc>(context).add(GetProjectsEvent())),
        ),
        title: Text(widget.project.name),
      ),
      body: ColumnCarousel(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewCoulmnView(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  void showNewCoulmnView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewColumnView();
        });
  }
}
