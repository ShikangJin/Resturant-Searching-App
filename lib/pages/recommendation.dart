import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:cmpe277_project/providers/map_provider.dart';
import 'package:cmpe277_project/providers/resturant_provider.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Recommendation extends StatefulWidget {
  Recommendation({Key key}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  bool initLoad = false;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final theme = Provider.of<ThemeProvider>(context);
    final resturants = Provider.of<ResturantProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final gMap = Provider.of<MapProvider>(context);
    if (!initLoad) {
      loading = true;
      resturants.getRecommendationFeed(auth).then((_) {
        setState(() {
          loading = false;
        });
      });
      initLoad = true;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(theme.primaryColor),
          title:
              Text("Recommendation", style: TextStyle(color: theme.textColor)),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 38 * rpx),
          child: Center(
            child: loading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...resturants.recommendationList.map(
                          (recommendation) => Resturant.createItem(
                              recommendation,
                              theme,
                              hrpx,
                              rpx,
                              context,
                              resturants,
                              auth,
                              gMap),
                        )
                      ],
                    )),
          ),
        ));
  }
}
