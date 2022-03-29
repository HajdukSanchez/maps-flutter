class SearchResult {
  final bool cancel; // If the user press the back button
  final bool manual; // If the user press add manually location

  SearchResult({required this.cancel, this.manual = false});

  @override
  String toString() {
    return 'SearchResult{cancel: $cancel, manual: $manual}';
  }
}
