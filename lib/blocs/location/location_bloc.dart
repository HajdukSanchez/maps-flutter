import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? _positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnNewUserLocationEvent>((event, emit) => emit(state.copyWith(
        lastKnownPosition: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation])));
  }

  Future getCurrentPosition() async {
    final Position location = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent(LatLng(location.latitude, location.longitude)));
  }

  void startFollowingUser() {
    _positionStream = Geolocator.getPositionStream().listen((event) {});
  }

  void stopFollowingUser() {
    _positionStream?.cancel(); // Close the stream
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
