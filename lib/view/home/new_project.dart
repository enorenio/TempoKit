import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';

class NewProject extends StatelessWidget {
  final _projectNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _newProjectFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Form(
              key: _newProjectFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Please enter name!' : null;
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
                      validator: (value) {
                        return value.isEmpty ? 'Please description!' : null;
                      },
                      controller: _descriptionController,
       
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
                            if (_newProjectFormKey.currentState.validate()) {
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
