import 'package:flutter/material.dart';
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
    return const Text("BuildResults");
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
