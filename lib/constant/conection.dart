import 'package:dio/dio.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiConnection = "http://localhost:9000/";
const socketServer = "http://localhost:9000";

final client = Dio();

Future<SharedPreferences> getStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<String?> getToken() async {
  final storage = await getStorage();
  return storage.getString('token');
}

Future<void> setCurrentNavigation(int id) async {
  (await getStorage()).setString('navigation', encryptId(id));
}

Future<void> setCurrentPayment(int id) async {
  (await getStorage()).setString('payment', encryptId(id));
}

Future<void> setCurrentDetail(int id) async {
  (await getStorage()).setString('detail', encryptId(id));
}

Future<String?> getCurrentNavigation() async {
  return (await getStorage()).getString('navigation');
}

Future<String?> getCurrentPayment() async {
  return (await getStorage()).getString('payment');
}

Future<String?> getCurrentDetail() async {
  return (await getStorage()).getString('detail');
}

Future<Map<String, dynamic>> getDataPackage(String id) async {
  try {
    final token = await getToken();
    final response = await client.get(
      '${apiConnection}api/v1/transaction/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response.data['data'];
  } on DioException catch (_) {
    rethrow;
  }
}

Future<bool> markAsDone(String id) async {
  try {
    final token = await getToken();
    final data = {'status': 'COMPLETED'};
    final response = await client.patch(
      '${apiConnection}api/v1/transaction/$id',
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response.data['data'] as bool;
  } on DioException catch (_) {
    rethrow;
  }
}

Future<bool> uploadTransferBill(Map<String, dynamic> file, String id) async {
  try {
    final token = await getToken();
    final response = await client.post(
      '${apiConnection}api/v1/transaction/$id/checkout',
      data: FormData.fromMap({
        'transfer_bill': MultipartFile.fromBytes(
          file['binary'],
          filename: file['name'],
        )
      }),
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response.data['data'] as bool;
  } on DioException catch (_) {
    rethrow;
  }
}
