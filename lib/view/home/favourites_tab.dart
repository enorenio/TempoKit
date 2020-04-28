import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/home/project_page.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({Key key}) : super(key: key);

  @override
  _FavouritesTabState createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetProjectsEvent(isFavorite: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (state is HomeError) {
        showError(context, state);
      } else if (state is ProjectsState) {
        if (state.projects.length > 0) {
          return ListView.builder(
              itemCount: state.projects.length,
              itemBuilder: (BuildContext context, int index) {
                Project current = state.projects[index];
                return ListTile(
                  title: Text(current.name),
                  subtitle: Text(current.description),
                  onTap: () => _navigateToProject(context, current),
                );
              });
        } else {
          return Center(
            child: Text('No projects created yet'),
          );
        }
      }
      return tempWidget;
    });
  }

  void _navigateToProject(BuildContext context, Project project) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectPage(project: project),
        ));
  }
}
