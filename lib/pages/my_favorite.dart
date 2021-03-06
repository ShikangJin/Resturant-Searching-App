import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:cmpe277_project/pages/resturant.dart';
import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:cmpe277_project/providers/map_provider.dart';
import 'package:cmpe277_project/providers/resturant_provider.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MyFavorite extends StatefulWidget {
  MyFavorite({Key key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  bool initLoad;
  bool loading;

  @override
  void initState() {
    super.initState();
    initLoad = false;
    loading = false;
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
      setState(() {
        loading = true;
      });
      resturants.fetchFavorite(auth).then((_) {
        setState(() {
          loading = false;
        });
      });
      initLoad = true;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(theme.primaryColor),
        title: Text("My Favorite", style: TextStyle(color: theme.textColor)),
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 10 * rpx, vertical: 14 * hrpx),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ...resturants.favoriteList.map((resturant) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResturantPage(
                                        auth: auth,
                                        theme: theme,
                                        resturants: resturants,
                                        curResturant: resturant,
                                        gMap: gMap,
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(theme.thirdColor)))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20 * rpx, vertical: 8 * hrpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      // margin: EdgeInsets.only(top: 12 * hrpx),
                                      width: 130 * rpx,
                                      height: 65 * hrpx,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                resturant.imageUrl),
                                          ))),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20 * rpx),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(resturant.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          RatingBar(
                                            ignoreGestures: true,
                                            initialRating: resturant.rate,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 12,
                                            itemPadding: EdgeInsets.only(
                                                right: 4.0, top: 4),
                                            itemBuilder: (context, _) => Icon(
                                                Icons.stars,
                                                color:
                                                    Color(theme.primaryColor)),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 3 * hrpx),
                                              child: Text(resturant.address,
                                                  style:
                                                      TextStyle(fontSize: 12))),
                                          Row(
                                            children: <Widget>[
                                              ...Resturant.getTags(
                                                  resturant.type == null
                                                      ? []
                                                      : resturant.type,
                                                  size: 12)
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     print('favorite');
                              //   },
                              //   child: Icon(
                              //     Icons.favorite,
                              //     color: Color(theme.thirdColor),
                              //   ),
                              // )
                            ],
                          ),
                        )))
                  ],
                ),
              ),
      ),
    );
  }
}
