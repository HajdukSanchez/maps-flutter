import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

import 'package:maps_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;
  final String baseTrafficURL = 'https://api.mapbox.com/directions/v5/mapbox/';

  // Add interceptor
  TrafficService() : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end,
      {String routingProfile = "driving"}) async {
    final String coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final String url = '$baseTrafficURL/$routingProfile/$coorsString';
    final Response respone = await _dioTraffic.get(url);
    final TrafficResponse data = TrafficResponse.fromMap(respone.data);
    return data;
  }
}
