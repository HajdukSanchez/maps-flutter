import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

class ButtonLocation extends StatelessWidget {
  const ButtonLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    void setLocationOnMap() {
      final userLocation =
          locationBloc.state.lastKnownPosition; // Las user location
      if (userLocation != null) {
        mapBloc.moveCamera(userLocation); // Move camera to user location
      }
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: setLocationOnMap,
              icon: const Icon(
                Icons.my_location_outlined,
                color: Colors.black,
              )),
        ));
  }
}
