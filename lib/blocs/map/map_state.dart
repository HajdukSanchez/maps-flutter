part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized; // Para saber si ya puedo usar el mapa
  final bool followingUser; // Para saber si estoy siguiendo al usuario

  const MapState({
    this.isMapInitialized = false,
    this.followingUser = false,
  });

  MapState copyWith({bool? isMapInitialized, bool? followingUser}) => MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        followingUser: followingUser ?? this.followingUser,
      );

  @override
  List<Object> get props => [isMapInitialized, followingUser];
}
