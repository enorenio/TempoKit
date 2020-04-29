import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/util/bloc/account/account_bloc.dart';

class NewCompanyView extends StatelessWidget {
  final companyNameController = TextEditingController();
  final memberEmailController = TextEditingController();
  final companyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child: SafeArea(
          minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: companyFormKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.drag_handle),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    return value.isEmpty ? 'Please enter company name!' : null;
                  },
                  controller: companyNameController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Your company...',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: memberEmailController,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Invite members. Enter emails...',
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
                      if (companyFormKey.currentState.validate()) {
                        BlocProvider.of<AccountBloc>(context).add(
                          CreateCompany(
                            company: Company(name: companyNameController.text),
                            assignees: null,
                          ),
                        ); // somehow pass list of users
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Add',
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
