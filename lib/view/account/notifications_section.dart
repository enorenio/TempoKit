import 'package:flutter/material.dart';
import 'package:tempokit/view/account/globals.dart';

class NotificationSection extends StatefulWidget {
  @override
  _NotificationSectionState createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  bool switchControl = false;
  var textHolder = 'OFF';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'ON';
      });
    } else {
      setState(() {
        switchControl = false;
        textHolder = 'OFF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          myTitle('Notifications'),
          Container(
              child: Row(children: <Widget>[
            myText(textHolder),
            Container(
                margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Switch(
                  onChanged: toggleSwitch,
                  value: switchControl,
                  activeColor: Colors.amberAccent,
                  activeTrackColor: Colors.deepOrangeAccent,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                )),
          ]))
        ]);
  }
}
