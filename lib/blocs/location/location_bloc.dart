import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? _positionStream;

  LocationBloc() : super(const LocationState()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future getCurrentPosition() async {
    final location = await Geolocator.getCurrentPosition();
    // TODO: Return object type LatLng from Google maps
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
