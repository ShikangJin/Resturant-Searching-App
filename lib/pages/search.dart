import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:cmpe277_project/providers/resturant_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final theme = Provider.of<ThemeProvider>(context);
    final resturants = Provider.of<ResturantProvider>(context);
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
                  return resturants.searchResult;
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
                            ...resturants.feedList.map(
                              (feed) =>
                                  Resturant.createItem(feed, theme, hrpx, rpx),
                            )
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
                  return Resturant.createItem(resturant, theme, hrpx, rpx);
                },
              ),
            )));
  }
}
