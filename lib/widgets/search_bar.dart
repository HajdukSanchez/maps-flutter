import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/search/delegates.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) =>
          !state.displayManualMarker ? const _SearchBarBody() : const SizedBox(),
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeInDown(
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              final result =
                  await showSearch(context: context, delegate: SearchDestinationDelegate());
              if (result == null) return;
              onSearchResults(context, result);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Text(
                "Where to ?",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSearchResults(BuildContext context, SearchResult result) async {
    if (result.manual) {
      BlocProvider.of<SearchBloc>(context).add(OnActivateManualMarkerEvent());
    } else if (result.userSerachSelected != null) {
      final start = BlocProvider.of<LocationBloc>(context).state.lastKnownPosition;
      final end =
          LatLng(result.userSerachSelected!.center.last, result.userSerachSelected!.center.first);
      final destination =
          await BlocProvider.of<SearchBloc>(context).getCoorsStartToEnd(start!, end);
      await BlocProvider.of<MapBloc>(context).drawRoutePolyline(destination);
    }
  }
}
