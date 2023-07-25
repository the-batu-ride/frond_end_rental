import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiConnection = "http://localhost:9000/";
// final FlutterSecureStorage accessToken =  FlutterSecureStorage();

final client = Dio();

Future<SharedPreferences> getStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<String?> getToken() async {
  final storage = await getStorage();
  return storage.getString('token');
}
