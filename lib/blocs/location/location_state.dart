part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  // TODO: add Last geolocation and history

  const LocationState({this.followingUser = false});

  @override
  List<Object> get props => [followingUser];
}
