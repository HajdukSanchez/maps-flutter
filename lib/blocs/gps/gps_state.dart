part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled; // true if GPS is enabled, false otherwise
  final bool
      isGpsPermissionGranted; // true if GPS permission is granted, false otherwise

  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  @override
  String toString() =>
      "{isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}";
}
