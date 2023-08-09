part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LoadMap extends MapEvent {
  final int id;

  const LoadMap(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateLocation extends MapEvent {
  final LatLng location;

  const UpdateLocation(this.location);

  @override
  List<Object> get props => [location];
}
