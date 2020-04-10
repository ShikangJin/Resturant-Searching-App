import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchBarController<Resturant> _searchBarController =
      SearchBarController();

  @override
  @override
  void initState() {
    super.initState();
  }

  createItem(Resturant resturant, var theme, double hrpx, double rpx) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 24 * hrpx),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(theme.thirdColor)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(resturant.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            RatingBar(
              ignoreGestures: true,
              initialRating: resturant.rate,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: EdgeInsets.only(right: 4.0, top: 4),
              itemBuilder: (context, _) =>
                  Icon(Icons.stars, color: Color(theme.primaryColor)),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            Container(
                margin: EdgeInsets.only(top: 12 * hrpx),
                width: 700 * rpx,
                height: 200 * hrpx,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(resturant.imageUrl),
                    )))
            // Container(
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: NetworkImage(resturant.imageUrl))),
            // )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * rpx),
            child: SafeArea(
              child: SearchBar<Resturant>(
                searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
                headerPadding: EdgeInsets.symmetric(horizontal: 10),
                listPadding:
                    EdgeInsets.symmetric(horizontal: 24 * rpx, vertical: 10),
                onSearch: (str) async {
                  // await Future.delayed(Duration(seconds: 3));
                  print(str);
                  List<Resturant> list = [];
                  list.add(Resturant(
                      1,
                      'test',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      3.5));
                  list.add(Resturant(
                      2,
                      'test2',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      4.0));
                  list.add(Resturant(
                      3,
                      'test3',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      3.5));
                  list.add(Resturant(
                      1,
                      'test',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      3.5));
                  list.add(Resturant(
                      2,
                      'test2',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      4.0));
                  list.add(Resturant(
                      3,
                      'test3',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      3.5));
                  list.add(Resturant(
                      1,
                      'test',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      3.5));
                  list.add(Resturant(
                      2,
                      'test2',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      4.0));
                  list.add(Resturant(
                      3,
                      'test3',
                      'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                      3.5));
                  return list;
                },
                searchBarController: _searchBarController,
                placeHolder: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24 * rpx, vertical: 10),
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Color(theme.thirdColor))),
                  child: Center(
                    child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            createItem(
                                Resturant(
                                    12,
                                    'Auto Feed',
                                    'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                                    4.0),
                                theme,
                                hrpx,
                                rpx),
                            createItem(
                                Resturant(
                                    12,
                                    'Auto Feed',
                                    'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                                    4.0),
                                theme,
                                hrpx,
                                rpx),
                            createItem(
                                Resturant(
                                    12,
                                    'Auto Feed',
                                    'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                                    4.0),
                                theme,
                                hrpx,
                                rpx),
                            createItem(
                                Resturant(
                                    12,
                                    'Auto Feed',
                                    'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
                                    4.0),
                                theme,
                                hrpx,
                                rpx)
                          ],
                        )),
                  ),
                ),
                cancellationWidget: Text(
                  "Cancel",
                  style: TextStyle(color: Color(theme.thirdColor)),
                ),
                emptyWidget: Center(
                  child: Text("No Available Resturant"),
                ),
                // indexedScaledTileBuilder: (int index) =>
                //     ScaledTile.count(1, index.isEven ? 2 : 1),
                header: Container(
                    padding: EdgeInsets.only(bottom: 12 * hrpx),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.grey[300]))),
                    child: Row(
                      children: <Widget>[
                        RaisedButton(
                          child: Text("\$"),
                          onPressed: () {
                            // _searchBarController.sortList((Post a, Post b) {
                            //   return a.body.compareTo(b.body);
                            // });
                          },
                        ),
                        RaisedButton(
                          child: Text("\$\$"),
                          onPressed: () {
                            // _searchBarController.removeSort();
                          },
                        ),
                        RaisedButton(
                          child: Text("\$\$\$"),
                          onPressed: () {
                            // isReplay = !isReplay;
                            // _searchBarController.replayLastSearch();
                          },
                        ),
                      ],
                    )),
                onCancelled: () {
                  print("Cancelled triggered");
                },
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 1,
                onItemFound: (Resturant resturant, int index) {
                  return createItem(resturant, theme, hrpx, rpx);
                },
              ),
            )));
  }
}
