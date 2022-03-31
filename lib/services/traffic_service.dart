import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

import 'package:maps_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficURL = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesURL = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  // Add interceptor
  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final String coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final String url = '$_baseTrafficURL/driving/$coorsString';
    final Response response = await _dioTraffic.get(url);
    final TrafficResponse data = TrafficResponse.fromMap(response.data);
    return data;
  }

  Future<List<Feature>> getResultsByQuery(String query, LatLng proximity) async {
    if (query.isEmpty) return [];
    final String url = '$_basePlacesURL/$query.json';
    // Another way to add query parameters
    final Response response = await _dioPlaces.get(url, queryParameters: {
      'proximity': '${proximity.longitude},${proximity.latitude}',
    });
    final placesResponse = PlacesResponse.fromJson(response.data);
    return placesResponse.features;
  }
}
