part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized; // To know if the map is initialized
  final bool isFollowingUser; // To know if the map is following the user
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = false,
    this.showMyRoute = false,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, showMyRoute, polylines, markers];
}
