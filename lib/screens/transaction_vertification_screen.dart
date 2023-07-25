import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class TransactionVerification extends StatefulWidget {
  const TransactionVerification({super.key});

  @override
  State<TransactionVerification> createState() =>
      _TransactionVerificationState();
}

class _TransactionVerificationState extends State<TransactionVerification> {
  File? bukti;
  bool preLoad = true;
  Map<String, dynamic>? data;

  Future<String> pickImageFromGalery() async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      var stream = await picked.readAsBytes();

      if (((stream.lengthInBytes / 1024) / 1024) > 2) {
        throw Exception('Gambar tidak boleh lebih dari 2MB!');
      }

      return picked.path;
    }

    throw Exception('Terdapat kesalahan');
  }

  @override
  void initState() {
    getCurrentPayment().then((value) async {
      if (value == null) {
        Navigator.of(context).pop();
      } else {
        try {
          final response = await getDataPackage(value);
          setState(() {
            data = response;
            preLoad = false;
          });
        } on DioException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message!),
            ),
          );
          Navigator.of(context).pop();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (cont) => GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Ionicons.chevron_back_outline,
              color: purpleChat,
            ),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Transactions Verification",
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
      body: preLoad
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.width * 0.05,
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
                      child: DottedBorder(
                        radius: const Radius.circular(12),
                        dashPattern: const [10, 5],
                        strokeWidth: 3,
                        color: mediumGreyColor,
                        borderType: BorderType.RRect,
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: 210,
                            height: 210,
                            margin: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                "Upload Pembayaran",
                                style: TextStyle(color: mediumGreyColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.31,
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: size.width * 0.31,
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: const Text(
                            "Confirm",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // Add space between the buttons
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
