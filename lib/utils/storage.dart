import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getStorage() async {
  return await SharedPreferences.getInstance();
}
