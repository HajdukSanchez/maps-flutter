import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker createMarker(
    {required String id,
    required LatLng location,
    required BitmapDescriptor iconImage,
    Offset anchor = const Offset(0.5, 1.0)}) {
  return Marker(
    anchor: anchor,
    markerId: MarkerId(id),
    position: location,
    icon: iconImage,
  );
}
