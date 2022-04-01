import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(_onActivateManualMarker);
    on<OnDisactivateManualMarkerEvent>(_onDisactivateManualMarker);
    on<OnNewPlacesFoundEvent>(_onNewPlacesFound);
    on<OnAddPlaceToHistoryEvent>(_onAddPlaceToHistory);
  }

  void _onActivateManualMarker(OnActivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: true));
  }

  void _onDisactivateManualMarker(OnDisactivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: false));
  }

  void _onNewPlacesFound(OnNewPlacesFoundEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(places: event.places));
  }

  void _onAddPlaceToHistory(OnAddPlaceToHistoryEvent event, Emitter<SearchState> emit) {
    final places = state.history
        .where((element) => element.id != event.place.id)
        .toList(); // Remove the place if it is already in the history
    emit(state.copyWith(history: [event.place, ...places]));
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final TrafficResponse response = await trafficService.getCoorsStartToEnd(start, end);
    final distance = response.routes[0].distance;
    final duration = response.routes[0].duration;
    // Decode geometry
    // The accuracyExponent is the number of decimals after the comma.
    final points = decodePolyline(response.routes[0].geometry, accuracyExponent: 6);
    final pointsList =
        points.map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble())).toList();
    return RouteDestination(points: pointsList, duration: duration, distance: distance);
  }

  Future getPlacesByQuery(
    String query,
    LatLng proximity,
  ) async {
    final List<Feature> features = await trafficService.getResultsByQuery(query, proximity);
    add(OnNewPlacesFoundEvent(features));
    return features;
  }
}
