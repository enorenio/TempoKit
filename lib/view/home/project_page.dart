import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/task_view.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';
import 'package:tempokit/model/column.dart' as c;

import '../../injection_container.dart';
import '../../model/user.dart';
import '../../util/repository.dart';

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
      body: MyCarousel(),
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

class MyCarousel extends StatefulWidget {
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetColumnsAndTasksEvent());
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
                return MyItem(
                  columnAndTasks: state.columnsAndTasks[index],
                );
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
    c.Column currentColumn = widget.columnAndTasks['column'];
    List<Task> currentTasks = widget.columnAndTasks['tasks'];
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                currentColumn.name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
            MyCont(
              child: Column(
                children: [
                  ...(currentTasks
                      .map((task) => ListTile(
                            
                            title: Text(task.name),
                            onTap: () {
                              print("You pressed task tile!");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskView(
                                      task: task,
                                    ),
                                  ));
                            },
                          ))
                      .toList()), //TODO: make excellent design for tasks
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => showNewRequestView(
                      column: currentColumn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNewRequestView({c.Column column}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewRequestView(
            column: column,
          );
        });
  }
}

class NewColumnView extends StatelessWidget {
  final columnNameController = TextEditingController();
  final columnFormKey = GlobalKey<FormState>();

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
      ),
    );
  }
}

class NewRequestView extends StatelessWidget {
  final c.Column column;

  final _taskNameController = TextEditingController();
  final _taskDescriptionController = new TextEditingController();
  DateTime _dateTime;



  final _requestFormKey = GlobalKey<FormState>();
  GlobalKey<_MyItemState> itemGlobalKey = new GlobalKey<_MyItemState>();

  NewRequestView({Key key, this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Form(
        key: _requestFormKey,
        child: ListView(
          children: <Widget>[
            Icon(Icons.drag_handle),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return 'Please enter task name!';
              },
              controller: _taskNameController,
              cursorColor: Color(0xFF3C4858),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Task name...',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 150,
                  child: FlatButton.icon(
                      icon: Icon(Icons.supervised_user_circle, size: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return UsersListView();
                            });
                      },
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Assigned to:',
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Username',
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: FlatButton.icon(
                    icon: Icon(Icons.date_range, size: 40),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050))
                          .then((date) {
                        _dateTime = date;
                      });
                    },
                    label: Text(
                      'Due Date',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
                controller: _taskDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Color(0xFF3C4858),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Description...',
                )),
            SizedBox(height: 20),
            ButtonTheme(
              minWidth: 150,
              child: RaisedButton(
                color: Color.fromRGBO(60, 60, 60, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  _handleNewTask(
                    context: context,
                    column: column,
                  );
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

  void _handleNewTask({BuildContext context, c.Column column}) async {
    if (_requestFormKey.currentState.validate()) {
      BlocProvider.of<HomeBloc>(context).add(
        CreateTaskEvent(
          task: Task(
            name: _taskNameController.text,
            description: _taskDescriptionController.text,
            colId: column.colId,
          ),
        ),
      );
      Navigator.pop(context);
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

class UsersListView extends StatefulWidget {
  const UsersListView({Key key}) : super(key: key);

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  List<User> selectedUsers = new List<User>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Assign to:"),
      content: Container(
          height: 400,
          width: 300,
          child: Column(
            children: <Widget>[
              Container(
                height: 325,
                child: FutureBuilder(
                  future: sl<Repository>().getUsers(), //TODO: delete this
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<User> data = snapshot.data;
                      return usersListView(context, data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              SizedBox(
                height: 27,
              ),
              ButtonTheme(
                minWidth: 150,
                child: RaisedButton(
                  color: Color.fromRGBO(60, 60, 60, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {},
                  child: Text(
                    'Assign',
                    style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<List<User>> _fetchTasks() async {
    //TO DO
  }
  ListView usersListView(context, data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return userTile(data[index]);
        });
  }

  CheckboxListTile userTile(User user) => CheckboxListTile(
        title: Text(user.uEmail,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        value: selectedUsers.contains(user) ? true : false,
        onChanged: (bool value) {
          setState(() {
            if (selectedUsers.contains(user)) {
              selectedUsers.remove(user);
            } else {
              selectedUsers.add(user);
            }
          });
        },
      );
}
