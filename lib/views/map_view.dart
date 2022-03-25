import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final double zoom;

  const MapView({Key? key, required this.initialLocation, this.zoom = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(initialLocation.latitude, initialLocation.longitude),
      zoom: zoom,
    );

    final size = MediaQuery.of(context).size; // Screen size

    return SizedBox(
      height: size.height,
      width: size.width,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapBloc.add(OnMapInitializedEvent(controller));
        },
      ),
    );
  }
}
