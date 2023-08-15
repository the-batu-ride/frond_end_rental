import 'package:dio/dio.dart';
import 'package:frond_end_rental/errors/unauthorize_error.dart';
import 'package:frond_end_rental/utils/storage.dart';

const _serverURL = 'https://odd-gold-yak-sock.cyclic.app/api/v1';
const socketServer = 'https://odd-gold-yak-sock.cyclic.app';

final _client = Dio(BaseOptions(baseUrl: _serverURL));

Future<Dio> getSecureHttpClient() async {
  final storage = await getStorage();
  final token = storage.getString('token');

  if (token == null || token == '') {
    throw const UnauthorizeError('Login terlebih dahulu');
  }

  _client.options.headers = {'Authorization': 'Bearer $token'};

  return _client;
}

Dio getPublicHttpClient() => _client;
