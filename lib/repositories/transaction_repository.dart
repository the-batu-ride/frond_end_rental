import 'package:dio/dio.dart';
import 'package:frond_end_rental/models/transaction.dart';
import 'package:frond_end_rental/utils/http.dart' show getSecureHttpClient;
import 'package:frond_end_rental/utils/security.dart' show encryptId;

class TransactionRepository {
  static const int _max = 10;

  static Future<List<Transaction>> getTransactions(int start) async {
    try {
      final client = await getSecureHttpClient();
      final url = '/transaction?limit=$_max&start=$start';
      final response = await client.get(url);
      return (response.data['data'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e))
          .toList();
    } on DioException catch (_) {
      rethrow;
    }
  }

  static Future<Transaction> getTransaction(int id) async {
    final client = await getSecureHttpClient();
    final enc = encryptId(id);

    try {
      final url = '/transaction/$enc';
      final response = await client.get(url);
      return Transaction.fromJson(response.data['data']);
    } on DioException catch (_) {
      rethrow;
    }
  }

  static Future<int> createTransaction(Map<String, dynamic> data) async {
    final client = await getSecureHttpClient();
    try {
      const url = '/transaction';
      final response = await client.post(url, data: data);
      return response.data['data']['id'];
    } on DioException catch (_) {
      rethrow;
    }
  }

  static Future<bool> markTransactionDone(int id) async {
    final client = await getSecureHttpClient();
    final enc = encryptId(id);
    try {
      final url = '/transaction/$enc';
      final data = {'status': 'COMPLETED'};
      await client.patch(url, data: data);
      return true;
    } on DioException catch (_) {
      return false;
    }
  }

  static Future<bool> uploadTransferBill(
    Map<String, dynamic> data,
    int id,
  ) async {
    final client = await getSecureHttpClient();
    final enc = encryptId(id);
    try {
      final url = '/transaction/$enc/checkout';
      final response = await client.post(url,
          data: FormData.fromMap({
            'transfer_bill': MultipartFile.fromBytes(
              data['binary'],
              filename: data['name'],
            )
          }));
      return response.data['data'] as bool;
    } on DioException catch (_) {
      return false;
    }
  }
}
