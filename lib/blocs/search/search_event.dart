part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnDisactivateManualMarkerEvent extends SearchEvent {}

class OnNewPlacesFoundEvent extends SearchEvent {
  final List<Feature> places;

  const OnNewPlacesFoundEvent(this.places);
}

class OnAddPlaceToHistoryEvent extends SearchEvent {
  final Feature place;

  const OnAddPlaceToHistoryEvent(this.place);
}
