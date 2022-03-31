import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  // Here we can change the initial configuration of the delegate
  SearchDestinationDelegate() : super(searchFieldLabel: 'Search');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: query == ''
            ? const Icon(
                Icons.search_rounded,
                color: Colors.black87,
              )
            : const Icon(
                Icons.clear_rounded,
                color: Colors.black87,
              ),
        onPressed: () {
          query = ''; // The Query cames from the SearchDelegate
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black87,
      ),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result); // This one is a method from SearchDelegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnownPosition;
    searchBloc.getPlacesByQuery(query, proximity!);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Text("Results");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.my_location_rounded,
            color: Colors.black87,
          ),
          title: const Text('Add location manually'),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        const Divider(),
      ],
    );
  }
}
