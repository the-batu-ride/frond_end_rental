import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/repositories/route_repository.dart';
import 'package:frond_end_rental/repositories/transaction_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<LoadMap>(_onLoadMap);
    on<UpdateLocation>(_onUpdateLocation);
  }

  _onLoadMap(LoadMap event, Emitter<MapState> emit) async {
    try {
      final response = await TransactionRepository.getTransaction(event.id);
      final start = LatLng(
        double.parse(response.package.latStart),
        double.parse(response.package.lngStart),
      );
      final end = LatLng(
        double.parse(response.package.latDestination),
        double.parse(response.package.lngDestination),
      );

      final routePoints = await RouteRepository.getRoute(start, end);

      emit(state.copyWith(
        status: MapStatus.loaded,
        points: [start, end],
        currentLoc: start,
        routePoints: routePoints,
      ));
    } on DioException catch (_) {
      emit(state.copyWith(status: MapStatus.error));
    }
  }

  _onUpdateLocation(UpdateLocation event, Emitter<MapState> emit) {
    final distance = Geolocator.distanceBetween(
      event.location.latitude,
      event.location.longitude,
      state.points.last.latitude,
      state.points.last.longitude,
    );

    emit(state.copyWith(
      currentLoc: event.location,
      disntance: distance,
    ));
  }
}
