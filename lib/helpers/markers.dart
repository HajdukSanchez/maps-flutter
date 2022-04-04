import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker createMarker({
  required String id,
  required LatLng location,
  required BitmapDescriptor iconImage,
  InfoWindow? information,
}) {
  return Marker(
    markerId: MarkerId(id),
    position: location,
    icon: iconImage,
    infoWindow: information ?? InfoWindow(title: id),
  );
}
