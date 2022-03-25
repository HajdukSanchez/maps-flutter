import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

class ButtonFollowUser extends StatelessWidget {
  const ButtonFollowUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    void setLocationOnMap(MapState state) {
      mapBloc.add(OnMapStartFollowingUserEvent());
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () => setLocationOnMap(state),
                  icon: Icon(
                    state.isFollowingUser
                        ? Icons.directions_run_rounded
                        : Icons.hail_rounded,
                    color: Colors.black,
                  ));
            },
          ),
        ));
  }
}
