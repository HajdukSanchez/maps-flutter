import 'package:maps_app/models/models.dart';

class SearchResult {
  final bool cancel; // If the user press the back button
  final bool manual; // If the user press add manually location
  final Feature? userSerachSelected; // If the user select a location from the search

  SearchResult({required this.cancel, this.manual = false, this.userSerachSelected});

  @override
  String toString() {
    return 'SearchResult{cancel: $cancel, manual: $manual, userSerachSelected: $userSerachSelected}';
  }
}
