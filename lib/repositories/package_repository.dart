import 'package:dio/dio.dart';
import 'package:frond_end_rental/models/package.dart';
import 'package:frond_end_rental/utils/http.dart' show getSecureHttpClient;

class PackageRepository {
  static Future<List<Package>> getPackages() async {
    final client = await getSecureHttpClient();

    try {
      final response = await client.get('/package');
      return (response.data['data'] as List<dynamic>)
          .map((e) => Package.fromJson(e))
          .toList();
    } on DioException catch (_) {
      rethrow;
    }
  }
}
