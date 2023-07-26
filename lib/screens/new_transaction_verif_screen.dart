import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../constant/colors.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  File? bukti;

  Future<String> pickImageFromGalery() async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      var stream = await picked.readAsBytes();

      if (((stream.lengthInBytes / 2048) / 2048) > 1) {
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
      body: Padding(
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
                width: size.width * 0.65,
                height: size.width * 0.40,
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
                      width: size.width * 0.65,
                      height: size.width * 0.40,
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
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              width: size.width * .65,
              decoration: const BoxDecoration(
                  color: purpleChat,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transfer ke Bank BARI",
                        style: TextStyle(fontSize: 10, color: whiteColor),
                      ),
                      Text(
                        "2212143121312",
                        style: TextStyle(
                            fontSize: 10,
                            color: whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              width: size.width * .65,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama Paket",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Paket Tour Malang",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Harga",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "20.200",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(size.width * 0.02),
                  child: SizedBox(
                    width: size.width * 0.65,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              18.0), // Adjust the value as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
