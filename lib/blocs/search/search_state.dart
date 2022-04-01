part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> places; // Places searched in our Serach delegate
  final List<Feature> history; // Places selected in our Serach delegate

  const SearchState(
      {this.displayManualMarker = false, this.places = const [], this.history = const []});

  SearchState copyWith(
          {bool? displayManualMarker, List<Feature>? places, List<Feature>? history}) =>
      SearchState(
          displayManualMarker: displayManualMarker ?? this.displayManualMarker,
          places: places ?? this.places,
          history: history ?? this.history);

  @override
  List<Object> get props => [displayManualMarker, places, history];
}
