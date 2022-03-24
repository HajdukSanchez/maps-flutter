import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

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
    return Scaffold(body: BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, state) {
      if (state.lastKnownPosition == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return Center(
        child: Text(
            "${state.lastKnownPosition!.latitude} / ${state.lastKnownPosition!.longitude}"),
      );
    }));
  }
}
