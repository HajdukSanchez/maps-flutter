import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getAssetImageMarker({String imagePath = 'assets/custom-pin.png'}) async {
  return BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5), imagePath);
}
