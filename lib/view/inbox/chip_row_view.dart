import 'package:flutter/material.dart';


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

    onSelected(index) {
      return (bool selected) {
        setState(() {
          _value = selected ? index : null;
        });
      };
    }

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
          onSelected: onSelected(0),
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            'Assigned to me',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 1,
          onSelected: onSelected(1),
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            '@Mentioned',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 2,
          onSelected: onSelected(2),
        ),
        SizedBox(width: 4.0),
        ChoiceChip(
          label: Text(
            'Assigned by me',
          ),
          labelStyle: _labelStyle,
          selectedColor: _selectedColor,
          selected: _value == 3,
          onSelected: onSelected(3),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

taskTitle(title) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
    child: Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
    ),
  );
}
