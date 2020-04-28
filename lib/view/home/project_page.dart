import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';
import 'package:tempokit/model/column.dart' as c;

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
      body: MyCarousel(project: widget.project),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewCoulmnView(project: widget.project),
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  void showNewCoulmnView({Project project}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewColumnView(project: project);
        });
  }
}

class MyCarousel extends StatefulWidget {
  final Project project;

  MyCarousel({this.project});
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context)
        .add(GetColumnsAndTasksEvent(project: widget.project));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (state is HomeError) {
        showError(context, state);
      } else if (state is ColumnsAndTasksState) {
        if (state.columnsAndTasks.length > 0) {
          return SizedBox(
            // you may want to use an aspect ratio here for tablet support
            height: 245.0,
            child: PageView.builder(
              // store this controller in a State to save the carousel scroll position
              controller: PageController(viewportFraction: 0.8),
              itemCount: state.columnsAndTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return MyItem(columnAndTasks: state.columnsAndTasks[index]);
              },
            ),
          );
        } else {
          return Center(
            child: Text('No columns created yet'),
          );
        }
      }
      return tempWidget;
    });
  }

  // _updateItemCount(String columnName) {
  //   setState(() {
  //     _itemCount++;
  //     itemName.add(columnName);
  //   });
  // }
}

class MyItem extends StatefulWidget {
  final dynamic columnAndTasks;

  MyItem({this.columnAndTasks});
  _MyItemState createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  widget.columnAndTasks['column'].name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ),
              MyCont(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => showNewRequestView(),
                ),
              ),
            ])));
  }

  void showNewRequestView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewRequestView();
        });
  }
}

class NewColumnView extends StatelessWidget {
  final Project project;

  final columnNameController = TextEditingController();
  final columnFormKey = GlobalKey<FormState>();

  // GlobalKey<_MyCarouselState> carouselGlobalKey =
  //     new GlobalKey<_MyCarouselState>();
  // void setCarouselState() {
  //   carouselGlobalKey.currentState._updateItemCount(columnNameController.text);
  // }

  NewColumnView({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: columnFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter column name!';
                  },
                  controller: columnNameController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Column name...',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromRGBO(60, 60, 60, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      if (columnFormKey.currentState.validate()) {
                        BlocProvider.of<HomeBloc>(context).add(
                          CreateColumnEvent(
                            project: project,
                            column: c.Column(name: columnNameController.text),
                          ),
                        );
                        Navigator.pop(context);
                        // setCarouselState();
                        // print(_itemCount);
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
              ],
            ),
          ),
        ));
  }
}

class NewRequestView extends StatelessWidget {
  final requestNameController = TextEditingController();
  final requestFormKey = GlobalKey<FormState>();
  GlobalKey<_MyItemState> itemGlobalKey = new GlobalKey<_MyItemState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: requestFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter request!';
                  },
                  controller: requestNameController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Your request...',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromRGBO(60, 60, 60, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      _handleNewTask();
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
              ],
            ),
          ),
        ));
  }

  void _handleNewTask() async {
    if (requestFormKey.currentState.validate()) {
      // Navigator.pop(context);
      //itemName.add(columnNameController.text);
      //setCarouselState();
      //itemName.removeLast();
      // print(_itemCount);
    }
  }
}

class MyCont extends StatelessWidget {
  Widget child;

  MyCont({this.child});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            margin: EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromRGBO(60, 60, 60, 1),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(13, 51, 32, 0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: this.child,
          ),
        ),
      ],
    );
  }
}
