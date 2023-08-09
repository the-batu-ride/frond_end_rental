import 'package:dio/dio.dart';
import 'package:frond_end_rental/errors/unauthorize_error.dart';
import 'package:frond_end_rental/models/auth.dart';
import 'package:frond_end_rental/models/register_model.dart';
import 'package:frond_end_rental/utils/http.dart';
import 'package:frond_end_rental/utils/security.dart' show encryptId;

class AuthRepository {
  static Future<AuthEntity> checkAuth() async {
    final client = await getSecureHttpClient();

    try {
      final response = await client.get('/auth/user');
      return AuthEntity.fromJson(response.data['data']);
    } on DioException catch (_) {
      throw const UnauthorizeError('Login terlebih dahulu');
    }
  }

  static Future<void> register(RegisterModel model) async {
    try {
      final client = getPublicHttpClient();
      await client.post('/auth', data: model.toMap());
    } on DioException catch (error) {
      if (error.response?.data['message'].runtimeType == List<dynamic>) {
        throw UnauthorizeError(error.response?.data['message'][0]);
      } else {
        rethrow;
      }
    }
  }

  static Future<void> update(RegisterModel model, int id) async {
    try {
      final enc = encryptId(id);
      final client = await getSecureHttpClient();
      await client.put('/auth/$enc', data: model.toMap());
    } on DioException catch (_) {
      rethrow;
    }
  }
}
