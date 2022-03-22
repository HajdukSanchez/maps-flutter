import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
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
    print("GPS is enable: $isEnable");
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    // This one is the listener for the GPS status chenges
    Geolocator.getServiceStatusStream().listen((event) {
      print("status: ${event.toString()}");
    });
    return isEnable;
  }
}
