
import 'package:shared_preferences/shared_preferences.dart'; 


const apiConnection = "http://192.168.1.10:9000/";
// final FlutterSecureStorage accessToken =  FlutterSecureStorage();

Future<SharedPreferences> getStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}



