import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;

  GpsBloc()
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));
    _init();
  }

  Future<void> _init() async {
    final isEnable = await _checkGpsStatus();
    add(GpsAndPermissionEvent(
        isGpsEnabled: isEnable,
        isGpsPermissionGranted: state.isGpsPermissionGranted));
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    // This one is the listener for the GPS status chenges
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isGpsEnabled = event.index == 1 ? true : false;
      add(GpsAndPermissionEvent(
          isGpsEnabled: isGpsEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
    return isEnable;
  }

  @override
  Future<void> close() {
    gpsServiceSubscription
        ?.cancel(); // This is for cancel the continuous listener
    return super.close();
  }
}
