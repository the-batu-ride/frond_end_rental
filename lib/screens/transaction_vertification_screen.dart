import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/utils/format_rupiah.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:image_picker/image_picker.dart';

class TransactionVerification extends StatefulWidget {
  final Map<String, dynamic> data;

  const TransactionVerification({super.key, required this.data});

  @override
  State<TransactionVerification> createState() =>
      _TransactionVerificationState();
}

class _TransactionVerificationState extends State<TransactionVerification> {
  File? bukti;

  Future<String> pickImageFromGalery() async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      var stream = await picked.readAsBytes();

      if (((stream.lengthInBytes / 1024) / 1024) > 1) {
        throw Exception('Gambar tidak boleh lebih dari 1MB!');
      }

      return picked.path;
    }

    throw Exception('Terdapat kesalahan');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom("Transaction Verification", null, context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.width * 0.05,
          ),
          Container(
            margin: const EdgeInsets.all(2),
            child: const Text(
              "Amount",
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              formatRupiah(double.parse(widget.data['package']['price'])),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: const Text(
              "Upload Bukti",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              try {
                final path = await pickImageFromGalery();
                setState(() {
                  bukti = File(path);
                });
              } on Exception catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
            },
            child: Container(
              width: 250,
              height: 250,
              color: Colors.white,
              child: Container(
                width: 230,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 230,
                margin: const EdgeInsets.all(20),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              "Total Transaction",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.data['package']['name']} ",
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                formatRupiah(double.parse(widget.data['package']['price'])),
                style: const TextStyle(color: Color.fromARGB(255, 201, 182, 4)),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: const Text(
              "Are you sure",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  margin: EdgeInsets.all(size.width * 0.02),
                  child: SizedBox(
                    width: size.width * 0.45,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final token = await getToken();
                          final id = encryptId(widget.data['id']);

                          final response = await client.post(
                            '${apiConnection}api/v1/transaction/$id/checkout',
                            data: FormData.fromMap({
                              'transfer_bill':
                                  await MultipartFile.fromFile(bukti!.path)
                            }),
                            options: Options(
                              headers: {'Authorization': 'Bearer $token'},
                            ),
                          );

                          print(response.data);
                        } on DioException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message!),
                            ),
                          );
                        }
                      },
                      child: const Text("Confirm"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
