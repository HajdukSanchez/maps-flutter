import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(_onActivateManualMarker);
    on<OnDisactivateManualMarkerEvent>(_onDisactivateManualMarker);
  }

  void _onActivateManualMarker(OnActivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: true));
  }

  void _onDisactivateManualMarker(OnDisactivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: false));
  }
}
