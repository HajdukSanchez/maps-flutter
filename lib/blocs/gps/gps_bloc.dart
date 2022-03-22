import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> askGpsAccess() async {
    final status = await Permission.location
        .request(); // Here we are going to tell the user for permissions to the application
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings(); // Open Settings
        break;
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription
        ?.cancel(); // This is for cancel the continuous listener
    return super.close();
  }
}
