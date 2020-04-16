import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:cmpe277_project/providers/map_provider.dart';
import 'package:cmpe277_project/providers/resturant_provider.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchBarController<Resturant> _searchBarController;
  bool initialFeed;
  bool searched;
  bool searching;
  List<String> filters;
  String sort;

  @override
  void initState() {
    super.initState();
    _searchBarController = SearchBarController();
    initialFeed = false;
    searched = false;
    searching = false;
    filters = new List();
    sort = 'default';
  }

  parsePrice() {
    String price = filters.join(',');
    return price.length > 0 ? price : null;
  }

  @override
  void dispose() {
    print('dispose search page');
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
    if (!initialFeed) {
      setState(() {
        searching = true;
      });
      resturants
          .getResturantFeed(auth, sort: sort, price: parsePrice())
          .then((_) {
        setState(() {
          searching = false;
        });
      });
      initialFeed = true;
    }
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
                  print('start search');
                  var listResult = await resturants.searchResturants(auth,
                      term: str, price: parsePrice(), sort: sort);
                  // print(listResult);
                  searched = true;
                  return listResult;
                },
                searchBarController: _searchBarController,
                placeHolder: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24 * rpx, vertical: 10),
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Color(theme.thirdColor))),
                  child: Center(
                    child: searching
                        ? CircularProgressIndicator()
                        : SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ...resturants.feedList.map(
                                  (feed) => Resturant.createItem(
                                      feed,
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
                                color: theme.textColor))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Row(
                          children: <Widget>[
                            RaisedButton(
                              color: filters.contains('1')
                                  ? Color(theme.primaryColor)
                                  : theme.textColor,
                              child: Text("\$",
                                  style: TextStyle(
                                      color: filters.contains('1')
                                          ? theme.textColor
                                          : Colors.black)),
                              onPressed: () {
                                bool actived = filters.contains("1");
                                if (actived) {
                                  filters.remove('1');
                                } else {
                                  filters.add('1');
                                }
                                setState(() {
                                  filters = filters;
                                });
                                _searchBarController.replayLastSearch();
                                if (!searched) {
                                  setState(() {
                                    searching = true;
                                  });
                                  resturants
                                      .getResturantFeed(auth,
                                          sort: sort, price: parsePrice())
                                      .then((_) {
                                    setState(() {
                                      searching = false;
                                    });
                                  });
                                }
                                // _searchBarController.sortList((Post a, Post b) {
                                //   return a.body.compareTo(b.body);
                                // });
                              },
                            ),
                            RaisedButton(
                                color: filters.contains('2')
                                    ? Color(theme.primaryColor)
                                    : theme.textColor,
                                child: Text("\$\$",
                                    style: TextStyle(
                                        color: filters.contains('2')
                                            ? theme.textColor
                                            : Colors.black)),
                                onPressed: () {
                                  bool actived = filters.contains("2");
                                  if (actived) {
                                    filters.remove('2');
                                  } else {
                                    filters.add('2');
                                  }
                                  setState(() {
                                    filters = filters;
                                  });
                                  _searchBarController.replayLastSearch();
                                  if (!searched) {
                                    setState(() {
                                      searching = true;
                                    });
                                    resturants
                                        .getResturantFeed(auth,
                                            sort: sort, price: parsePrice())
                                        .then((_) {
                                      setState(() {
                                        searching = false;
                                      });
                                    });
                                  }
                                }),
                            RaisedButton(
                              color: filters.contains('3')
                                  ? Color(theme.primaryColor)
                                  : theme.textColor,
                              child: Text("\$\$\$",
                                  style: TextStyle(
                                      color: filters.contains('3')
                                          ? theme.textColor
                                          : Colors.black)),
                              onPressed: () {
                                bool actived = filters.contains("3");
                                if (actived) {
                                  filters.remove('3');
                                } else {
                                  filters.add('3');
                                }
                                setState(() {
                                  filters = filters;
                                });
                                _searchBarController.replayLastSearch();
                                if (!searched) {
                                  setState(() {
                                    searching = true;
                                  });
                                  resturants
                                      .getResturantFeed(auth,
                                          sort: sort, price: parsePrice())
                                      .then((_) {
                                    setState(() {
                                      searching = false;
                                    });
                                  });
                                }
                              },
                            )
                          ],
                        )),
                        Container(
                            margin: EdgeInsets.only(left: 20 * rpx),
                            child: RaisedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 300 * hrpx,
                                        color: Color(0xFF737373),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            20),
                                                    topRight:
                                                        const Radius.circular(
                                                            20))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(
                                                            theme.primaryColor),
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: const Radius
                                                                .circular(20),
                                                            topRight: const Radius
                                                                .circular(20))),
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 16 * hrpx),
                                                    // margin: EdgeInsets.symmetric(
                                                    //   horizontal: 10 * rpx,
                                                    // ),
                                                    child: Text('Sort by',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: theme
                                                                .textColor))),
                                                Container(
                                                  width: 750 * rpx,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16 * hrpx),
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 20 * rpx,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              color: theme
                                                                  .textColor),
                                                          bottom: BorderSide(
                                                              color: theme
                                                                  .textColor))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          'Recommended (default)',
                                                          style: TextStyle(
                                                              fontSize: 18)),
                                                      Radio(
                                                        activeColor: Color(
                                                            theme.thirdColor),
                                                        value: 'default',
                                                        groupValue: sort,
                                                        onChanged:
                                                            (String value) {
                                                          setState(() {
                                                            sort = value;
                                                            searching = true;
                                                          });
                                                          if (!searched) {
                                                            resturants
                                                                .getResturantFeed(
                                                                    auth,
                                                                    price:
                                                                        parsePrice(),
                                                                    sort: sort)
                                                                .then((_) {
                                                              setState(() {
                                                                searching =
                                                                    false;
                                                              });
                                                            });
                                                          } else {
                                                            _searchBarController
                                                                .replayLastSearch();
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    width: 750 * rpx,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                16 * hrpx),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20 * rpx,
                                                    ),
                                                    // decoration: BoxDecoration(
                                                    //     border: Border(
                                                    //         bottom: BorderSide(
                                                    //             color: Color(theme
                                                    //                 .thirdColor)))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text('Rating',
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                        Radio(
                                                          activeColor: Color(
                                                              theme.thirdColor),
                                                          value: 'rating',
                                                          groupValue: sort,
                                                          onChanged:
                                                              (String value) {
                                                            setState(() {
                                                              sort = value;
                                                              searching = true;
                                                            });
                                                            if (!searched) {
                                                              resturants
                                                                  .getResturantFeed(
                                                                      auth,
                                                                      price:
                                                                          parsePrice(),
                                                                      sort:
                                                                          sort)
                                                                  .then((_) {
                                                                setState(() {
                                                                  searching =
                                                                      false;
                                                                });
                                                              });
                                                            } else {
                                                              _searchBarController
                                                                  .replayLastSearch();
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            )),
                                      );
                                    });
                              },
                              child: Text('Sort'),
                            ))
                      ],
                    )),
                onCancelled: () {
                  print("Cancelled triggered");
                  searched = false;
                  setState(() {
                    searching = true;
                  });
                  resturants
                      .getResturantFeed(auth, sort: sort, price: parsePrice())
                      .then((_) {
                    setState(() {
                      searching = false;
                    });
                  });
                },
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 1,
                onItemFound: (Resturant resturant, int index) {
                  return Resturant.createItem(resturant, theme, hrpx, rpx,
                      context, resturants, auth, gMap);
                },
              ),
            )));
  }
}
