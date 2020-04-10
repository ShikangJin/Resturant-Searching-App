import 'package:flutter/material.dart';

class Recommendation extends StatefulWidget {
  Recommendation({Key key}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('recommendation'),
      ),
    );
  }
}
