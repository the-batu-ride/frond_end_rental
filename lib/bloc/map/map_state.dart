part of 'map_bloc.dart';

enum MapStatus { initial, success, error, loaded }

final class MapState extends Equatable {
  final List<LatLng> routePoints;
  final MapStatus status;
  final LatLng? currentLoc;
  final List<LatLng> points;
  final double disntance;

  const MapState({
    this.routePoints = const <LatLng>[],
    this.status = MapStatus.initial,
    this.currentLoc,
    this.points = const <LatLng>[],
    this.disntance = 1000,
  });

  MapState copyWith({
    List<LatLng>? routePoints,
    MapStatus? status,
    LatLng? currentLoc,
    List<LatLng>? points,
    double? disntance,
  }) =>
      MapState(
        routePoints: routePoints ?? this.routePoints,
        status: status ?? this.status,
        currentLoc: currentLoc ?? this.currentLoc,
        points: points ?? this.points,
        disntance: disntance ?? this.disntance,
      );

  @override
  List<Object?> get props =>
      [routePoints, status, currentLoc, points, disntance];
}
