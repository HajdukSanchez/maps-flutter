import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getAssetImageMarker({String imagePath = 'assets/custom-pin.png'}) async {
  // Device pixel ratio is for the size of the marker
  return BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5), imagePath);
}

Future<BitmapDescriptor> getNetworkImageMarker(
    {String url =
        'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png'}) async {
  // We need the bytes of the response (image)
  final Response response =
      await Dio().get(url, options: Options(responseType: ResponseType.bytes));
// Process to Resize image
  final imageCodec =
      await instantiateImageCodec(response.data, targetHeight: 150, targetWidth: 150);
  final frame = await imageCodec.getNextFrame();
  final data =
      await frame.image.toByteData(format: ImageByteFormat.png); // We change the format to png
  if (data == null) {
    return await getAssetImageMarker();
  }

  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
