import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Container(
            height: 32.0,
            child: ChipRow(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ChipRow extends StatefulWidget {
  @override
  _ChipRowState createState() => _ChipRowState();
}

class _ChipRowState extends State<ChipRow> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = Theme.of(context).textTheme.body2;
    Color _selectedColor = Theme.of(context).accentColor;

    return ListView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(width: 16.0),
        ChoiceChip(
          label: Text(
            'All',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 0,
          onSelected: (bool selected) {
            setState(() {
              _value = selected ? 0 : null;
            });
          },
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            'Assigned to me',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 1,
          onSelected: (bool selected) {
            setState(() {
              _value = selected ? 1 : null;
            });
          },
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            '@Mentioned',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 2,
          onSelected: (bool selected) {
            setState(() {
              _value = selected ? 2 : null;
            });
          },
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            'Assigned by me',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 3,
          onSelected: (bool selected) {
            setState(() {
              _value = selected ? 3 : null;
            });
          },
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}
