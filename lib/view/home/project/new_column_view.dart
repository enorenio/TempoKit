import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';
import 'package:tempokit/model/column.dart' as c;

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
                  return value.isEmpty ? 'Please enter column name!' : null;
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
