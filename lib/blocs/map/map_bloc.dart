import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/enums/enums.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? _locationStateSubscription;
  LatLng? mapCenterLocation;
  final LocationBloc locationBloc;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap); // We use methods inside the Class for organize the code
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<ToggleShowMyRouteEvent>(_toggleShowMyRoute);
    on<OnMapStartFollowingUserEvent>(_startFollowingUser);
    on<OnMapStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<DisplayPolylinesEvent>(
        (event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers)));
    _startTrackingUser();
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme)); // Here we set the style of the map
    emit(state.copyWith(isMapInitialized: true));
  }

  // Here we suscribe to the location State in order to know when the user location change
  void _startTrackingUser() {
    _locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownPosition != null) {
        // If we have last location, we have history of the user
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if (!state.isFollowingUser) return;
      if (locationState.lastKnownPosition == null) return;
      moveCamera(locationState.lastKnownPosition!);
    });
  }

  void _startFollowingUser(OnMapStartFollowingUserEvent event, Emitter<MapState> emit) {
    moveCamera(locationBloc
        .state.lastKnownPosition!); // Move camera and then start to following the user again
    emit(state.copyWith(isFollowingUser: true));
  }

  void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = createPolyline(id: PolylineEnum.myRoute.name);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines[PolylineEnum.myRoute.name] =
        myRoute; // We create a copy because maybe we are going to re do this event

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _toggleShowMyRoute(ToggleShowMyRouteEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(showMyRoute: !state.showMyRoute));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = createPolyline(id: PolylineEnum.manualRoute.name, points: destination.points);
    final startMarker =
        createMarker(id: MarkerEnum.startMarker.name, location: destination.points.first);
    final finalMarker = createMarker(
      id: MarkerEnum.finalMarker.name,
      location: destination.points.last,
      information: const InfoWindow(title: "Info window", snippet: "This is the information"),
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines[PolylineEnum.manualRoute.name] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers[MarkerEnum.startMarker.name] = startMarker;
    currentMarkers[MarkerEnum.finalMarker.name] = finalMarker;

    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));
    await Future.delayed(const Duration(milliseconds: 300), () {
      _mapController?.showMarkerInfoWindow(MarkerId(MarkerEnum.finalMarker.name));
    }); // To open the info window by default
  }

  @override
  Future<void> close() {
    _locationStateSubscription?.cancel();
    return super.close();
  }
}
