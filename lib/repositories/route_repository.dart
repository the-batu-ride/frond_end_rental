import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart' show LatLng;

class RouteRepository {
  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final client = Dio();
    final routePoints = <LatLng>[];

    try {
      final url =
          'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?steps=true&annotations=true&geometries=geojson&overview=full';
      final response = await client.get(url);
      final data = response.data?['routes'][0]['geometry']['coordinates'] ?? [];

      for (int i = 0; i < data.length; i++) {
        var reep = data[i].toString();
        reep = reep.replaceAll('[', '');
        reep = reep.replaceAll(']', '');
        final loc = reep.split(',');

        routePoints.add(LatLng(double.parse(loc[1]), double.parse(loc[0])));
      }

      return routePoints;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
