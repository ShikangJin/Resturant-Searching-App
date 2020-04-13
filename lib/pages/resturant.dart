import 'dart:async';

import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResturantPage extends StatefulWidget {
  ResturantPage(
      {Key key,
      @required this.theme,
      @required this.resturants,
      @required this.curResturant})
      : super(key: key);
  final theme;
  final resturants;
  final curResturant;
  @override
  _ResturantPageState createState() => _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.curResturant.lat, widget.curResturant.lng),
      zoom: 20,
    );
    Set<Marker> markers = Set();
    markers.add(Marker(
        markerId: MarkerId(widget.curResturant.name),
        position: LatLng(widget.curResturant.lat, widget.curResturant.lng)));
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
                          left: 20 * rpx,
                          bottom: 4 * hrpx,
                          right: 20 * rpx),
                      child: Text(
                        widget.curResturant.name,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 4 * hrpx,
                          left: 20 * rpx,
                          bottom: 4 * hrpx,
                          right: 20 * rpx),
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
                          left: 20 * rpx,
                          bottom: 4 * hrpx,
                          right: 20 * rpx),
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
                          left: 20 * rpx,
                          bottom: 4 * hrpx,
                          right: 20 * rpx),
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
                        child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            markers: markers)),
                  ],
                ))));
  }
}
