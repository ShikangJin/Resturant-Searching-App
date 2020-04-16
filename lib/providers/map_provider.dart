import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  Completer<GoogleMapController> _controller;
  var map;
  Set<Marker> markers;

  MapProvider();

  getMap(LatLng position, Marker marker) {
    markers = new Set();
    markers.add(marker);
    _controller = Completer();
    map = GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: position, zoom: 20),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers);
    return map;
  }
}
