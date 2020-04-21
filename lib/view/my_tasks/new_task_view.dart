import 'package:flutter/material.dart';

class NewTaskView extends StatelessWidget {
  final taskNameController = TextEditingController();
  final taskFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: taskFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter task name!';
                  },
                  controller: taskNameController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Task name...',
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
                      if (taskFormKey.currentState.validate()) {
                        Navigator.pop(context);
                        print("New task created: " + taskNameController.text);
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
