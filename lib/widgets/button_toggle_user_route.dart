import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

class ButtonToggleUserRoute extends StatelessWidget {
  const ButtonToggleUserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    void setLocationOnMap() {
      mapBloc.add(ToggleShowMyRouteEvent());
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: setLocationOnMap,
                    icon: Icon(
                      state.showMyRoute ? Icons.more_horiz_rounded : Icons.line_axis_rounded,
                      color: Colors.black,
                    ));
              },
            )));
  }
}
