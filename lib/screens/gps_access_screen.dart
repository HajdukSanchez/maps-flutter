import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(builder: ((context, state) {
          return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccessButton();
        })),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void requestGPSAccess() {
      final gpsBloc = BlocProvider.of<GpsBloc>(context);
      gpsBloc.askGpsAccess();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
          child: const Text(
            "It is necessary to enable GPS access in order to use this app",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ),
        MaterialButton(
          onPressed: requestGPSAccess,
          child: const Text(
            "Request access",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          color: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          elevation: 0,
          splashColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Enable GPS to continue',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
    );
  }
}
