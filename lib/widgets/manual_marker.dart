import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) =>
          state.displayManualMarker ? const _ManualMarkerBody() : const SizedBox(),
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 50, left: 20, child: _ButtonBack()),
          Center(
              child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: BounceInDown(
                      from: 150, child: const Icon(Icons.location_on_rounded, size: 50)))),
          Positioned(
              bottom: 25,
              left: 20,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: size.width - 100,
                  child: const Text(
                    'Confirm Location',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  color: Colors.black,
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                ),
              ))
        ],
      ),
    );
  }
}

class _ButtonBack extends StatelessWidget {
  const _ButtonBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ))),
    );
  }
}
