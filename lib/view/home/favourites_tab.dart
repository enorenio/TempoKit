import 'package:flutter/material.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({Key key}) : super(key: key);

  @override
  _FavouritesTabState createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${this.widget}'),
    );
  }
}