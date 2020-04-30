import 'package:flutter/material.dart';
import 'package:tempokit/model/user.dart';

class UsersListView extends StatefulWidget {
  final List<User> allUsers;
  UsersListView({Key key, this.allUsers}) : super(key: key);

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
                child: usersListView(context, widget.allUsers),
                // child: FutureBuilder(
                //   future: sl<Repository>().getUsers(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       List<User> data = snapshot.data;
                //       return usersListView(context, data);
                //     } else if (snapshot.hasError) {
                //       return Text("${snapshot.error}");
                //     }
                //     return Center(child: CircularProgressIndicator());
                //   },
                // ),
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

  ListView usersListView(context, allUsers) {
    return ListView.builder(
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          return userTile(user: allUsers[index]);
        });
  }

  CheckboxListTile userTile({User user}) => CheckboxListTile(
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
