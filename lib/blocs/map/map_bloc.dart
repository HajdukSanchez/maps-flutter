import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/enums/enums.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? _locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap); // We use methods inside the Class for organize the code
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<ToggleShowMyRouteEvent>(_toggleShowMyRoute);
    on<OnMapStartFollowingUserEvent>(_startFollowingUser);
    on<OnMapStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
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
    final myRoute = Polyline(
        width: 5,
        polylineId: PolylineId(PolylineEnum.myRoute.name),
        color: Colors.black,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines[PolylineEnum.myRoute.name] =
        myRoute; // We create a copy because maybe we are going to re do this event
    emit(state.copyWith(polylines: currentPolylines));
  }

  void _toggleShowMyRoute(ToggleShowMyRouteEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(showMyRoute: !state.showMyRoute));
  }

  @override
  Future<void> close() {
    _locationStateSubscription?.cancel();
    return super.close();
  }
}
