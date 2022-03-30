import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/enums/enums.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    _locationBloc.getCurrentPosition();
    _locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    _locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<LocationBloc, LocationState>(builder: (BuildContext context, locationState) {
        if (locationState.lastKnownPosition == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {
            Map<String, Polyline> polylines = Map<String, Polyline>.from(mapState.polylines);
            if (!mapState.showMyRoute) {
              polylines.remove(PolylineEnum.myRoute.name); // Remove the Polyline
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  MapView(
                    initialLocation: locationState.lastKnownPosition!,
                    polylines: polylines.values.toSet(),
                    markers: mapState.markers.values.toSet(),
                  ),
                  const SearchBar(),
                  const ManualMarker()
                ],
              ),
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ButtonToggleUserRoute(),
          ButtonFollowUser(),
          ButtonLocation(),
        ],
      ),
    );
  }
}
