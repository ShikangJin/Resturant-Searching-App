import 'package:flutter/material.dart';

class MyFavorite extends StatefulWidget {
  MyFavorite({Key key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('my favorite'),
      ),
    );
  }
}
