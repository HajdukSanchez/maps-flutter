import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(_onActivateManualMarker);
    on<OnDisactivateManualMarkerEvent>(_onDisactivateManualMarker);
  }

  void _onActivateManualMarker(OnActivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: true));
  }

  void _onDisactivateManualMarker(OnDisactivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: false));
  }

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final TrafficResponse respone = await trafficService.getCoorsStartToEnd(start, end);
    return respone;
  }
}
