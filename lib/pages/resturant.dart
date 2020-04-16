import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResturantPage extends StatefulWidget {
  ResturantPage({
    Key key,
    @required this.theme,
    @required this.resturants,
    @required this.curResturant,
    @required this.auth,
    @required this.gMap,
  }) : super(key: key);
  final theme;
  final resturants;
  final curResturant;
  final auth;
  final gMap;
  @override
  _ResturantPageState createState() => _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage> {
  // Completer<GoogleMapController> _controller;
  List<String> photoList;
  bool favorite = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // _controller = Completer();
    widget.resturants
        .getCommentByResturant(widget.auth, widget.curResturant.id);
    widget.resturants
        .getDetail(widget.auth, widget.curResturant.id)
        .then((res) {
      setState(() {
        photoList = res[0];
        favorite = res[1];
      });
    });
  }

  @override
  void dispose() {
    photoList.clear();
    print('dispose resturant');
    super.dispose();
  }

  getCommentItem(comment, hrpx, rpx) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8 * hrpx),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 2 * hrpx),
                child: Text(comment.posterName,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            Container(
                padding: EdgeInsets.symmetric(vertical: 2 * hrpx),
                child: RatingBar(
                  ignoreGestures: true,
                  initialRating: comment.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  itemPadding: EdgeInsets.only(right: 4.0, top: 4),
                  itemBuilder: (context, _) => Icon(Icons.stars,
                      color: Color(widget.theme.primaryColor)),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )),
            Container(
                padding: EdgeInsets.symmetric(vertical: 2 * hrpx),
                child: Text(comment.comment,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    // final CameraPosition position = CameraPosition(
    //   target: LatLng(widget.curResturant.lat, widget.curResturant.lng),
    //   zoom: 20,
    // );

    // Set<Marker> markers = Set();
    // markers.add(Marker(
    //     markerId: MarkerId(widget.curResturant.name),
    //     position: LatLng(widget.curResturant.lat, widget.curResturant.lng)));
    var commentlist = widget.resturants?.commentList?.map((comment) {
      return getCommentItem(comment, hrpx, rpx);
    });
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: widget.theme.textColor),
          title: Text(
            widget.curResturant.name,
            style: TextStyle(color: widget.theme.textColor),
          ),
          backgroundColor: Color(widget.theme.primaryColor),
        ),
        body: Container(
            child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 160 * hrpx,
                        width: 750 * rpx,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.curResturant.imageUrl),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10 * hrpx,
                            left: 30 * rpx,
                            bottom: 4 * hrpx,
                            right: 30 * rpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.curResturant.name,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (favorite) {
                                    widget.resturants
                                        .removeFavorite(
                                            widget.auth, widget.curResturant.id)
                                        .then((res) {
                                      setState(() {
                                        loading = false;
                                        favorite = res ? false : true;
                                      });
                                    });
                                  } else {
                                    widget.resturants
                                        .addFavorite(
                                            widget.auth, widget.curResturant.id)
                                        .then((res) {
                                      setState(() {
                                        loading = false;
                                        favorite = res ? true : false;
                                      });
                                    });
                                  }
                                },
                                child: Icon(Icons.favorite,
                                    color: favorite
                                        ? Color(widget.theme.thirdColor)
                                        : Colors.grey))
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          top: 4 * hrpx,
                          left: 30 * rpx,
                          bottom: 4 * hrpx,
                          right: 30 * rpx),
                      child: RatingBar(
                        ignoreGestures: true,
                        initialRating: widget.curResturant.rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.only(right: 4.0, top: 4),
                        itemBuilder: (context, _) => Icon(Icons.stars,
                            color: Color(widget.theme.primaryColor)),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 4 * hrpx,
                          left: 30 * rpx,
                          bottom: 4 * hrpx,
                          right: 30 * rpx),
                      child: Row(
                        children: <Widget>[
                          Text('${widget.curResturant.price} '),
                          ...Resturant.getTags(widget.curResturant.type == null
                              ? []
                              : widget.curResturant.type)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 4 * hrpx,
                          left: 30 * rpx,
                          bottom: 4 * hrpx,
                          right: 30 * rpx),
                      child: Text(widget.curResturant.address,
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10 * hrpx,
                        bottom: 4 * hrpx,
                      ),
                      height: 160 * hrpx,
                      width: 750 * rpx,
                      child: widget.gMap.getMap(
                          LatLng(
                              widget.curResturant.lat, widget.curResturant.lng),
                          Marker(
                              markerId: MarkerId(widget.curResturant.name),
                              position: LatLng(widget.curResturant.lat,
                                  widget.curResturant.lng))),
                      // GoogleMap(
                      //     mapType: MapType.normal,
                      //     initialCameraPosition: _kGooglePlex,
                      //     onMapCreated: (GoogleMapController controller) {
                      //       _controller.complete(controller);
                      //     },
                      //     markers: markers)
                    ),
                    photoList != null && photoList.length > 0
                        ? Container(
                            margin: EdgeInsets.only(
                                top: 10 * hrpx,
                                left: 30 * rpx,
                                bottom: 4 * hrpx,
                                right: 30 * rpx),
                            child: Column(
                              // mainAxisSize: ,
                              children: <Widget>[
                                Container(
                                    width: 750 * rpx,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10 * hrpx),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color:
                                                    widget.theme.textColor))),
                                    child: Text('Photos',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    width: 750 * rpx,
                                    height: 160 * hrpx,
                                    child: Swiper(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            margin:
                                                EdgeInsets.only(top: 12 * hrpx),
                                            // width: 700 * rpx,
                                            // height: 160 * hrpx,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      photoList[index]),
                                                )));
                                        // return Text('ss');
                                      },
                                      itemCount: photoList.length,
                                      pagination: new SwiperPagination(),
                                      control: new SwiperControl(),
                                    )),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10 * hrpx,
                            left: 30 * rpx,
                            bottom: 4 * hrpx,
                            right: 30 * rpx),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 750 * rpx,
                                padding:
                                    EdgeInsets.symmetric(vertical: 10 * hrpx),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: widget.theme.textColor))),
                                child: Text('Comments',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                            ...(commentlist == null ? [] : commentlist)
                          ],
                        ))
                  ],
                ))));
  }
}
