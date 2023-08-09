import 'package:dio/dio.dart';
import 'package:frond_end_rental/models/bike.dart';
import 'package:frond_end_rental/utils/http.dart' show getSecureHttpClient;
import 'package:frond_end_rental/utils/security.dart' show encryptId;

class BikeRepository {
  static Future<Bike> getBikeByID(int id) async {
    final client = await getSecureHttpClient();
    final enc = encryptId(id);

    try {
      final response = await client.get('/bike/$enc');
      return Bike.fromJson(response.data['data']);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
