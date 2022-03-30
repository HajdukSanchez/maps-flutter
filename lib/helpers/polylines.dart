import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Polyline createPolyline({
  required String id,
  List<LatLng> points = const <LatLng>[],
}) {
  return Polyline(
    width: 5,
    points: points,
    color: Colors.black,
    endCap: Cap.roundCap,
    startCap: Cap.roundCap,
    polylineId: PolylineId(id),
  );
}
