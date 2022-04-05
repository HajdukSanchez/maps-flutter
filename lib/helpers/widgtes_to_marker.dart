import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/markers/markers.dart';

Future<BitmapDescriptor> getStartCustomMarker(String description) async {
  return await _createCustomMarker(StartMarkerPainter(description: description));
}

Future<BitmapDescriptor> getEndCustomMarker(int duration, String description) async {
  return await _createCustomMarker(
      EndMarkerPainter(minutes: duration.toString(), description: description));
}

Future<BitmapDescriptor> _createCustomMarker(CustomPainter marker) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  const size = Size(350, 150); // size of the widget marker

  marker.paint(canvas, size); // Draw the marker

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png); // PNG format

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
