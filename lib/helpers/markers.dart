import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker createMarker(
  String id,
  LatLng location,
) {
  return Marker(
    markerId: MarkerId(id),
    position: location,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  );
}
