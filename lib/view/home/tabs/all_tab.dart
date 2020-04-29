import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/home/project_page.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';

class AllTab extends StatefulWidget {
  const AllTab({Key key}) : super(key: key);

  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetProjectsEvent());
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
                  onTap: () => _navigateToProject(
                    context: context,
                    project: current,
                  ),
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

  void _navigateToProject({BuildContext context, Project project}) async {
    BlocProvider.of<HomeBloc>(context).add(SelectProjectEvent(project: project));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectPage(project: project),
        ));
  }
}