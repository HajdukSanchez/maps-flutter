import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  final Dio _dioTraffic;
  final String baseTrafficURL = 'https://api.mapbox.com/directions/v5/mapbox/';

  TrafficService() : _dioTraffic = Dio();

  Future getCoorsStartToEnd(LatLng start, LatLng end, {String routingProfile = "driving"}) async {
    final coorsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$baseTrafficURL/$routingProfile/$coorsString';
    final respone = await _dioTraffic.get(url);
    return respone.data;
  }
}
