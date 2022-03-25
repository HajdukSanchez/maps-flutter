part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized; // To know if the map is initialized
  final bool isFollowingUser; // To know if the map is following the user

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = false,
  });

  MapState copyWith({bool? isMapInitialized, bool? isFollowingUser}) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser];
}
