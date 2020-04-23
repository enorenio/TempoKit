import 'package:flutter/material.dart';

class NewTaskView extends StatelessWidget {
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
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
                          onPressed: () {},
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
                              lastDate: DateTime(2050));
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
                    controller: taskDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLength: null,
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
