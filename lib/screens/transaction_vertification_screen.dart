import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';
import 'package:frond_end_rental/utils/format_rupiah.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TransactionVerification extends StatefulWidget {
  const TransactionVerification({super.key});

  @override
  State<TransactionVerification> createState() =>
      _TransactionVerificationState();
}

class _TransactionVerificationState extends State<TransactionVerification> {
  Map<String, dynamic>? bukti;
  bool preLoad = true;
  bool isPaid = false;
  Map<String, dynamic>? data;
  final clientSocket = io(socketServer).connect();

  Future<dynamic> pickImageFromGalery() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      if (result.files.isNotEmpty) {
        final file = result.files.single;
        final Uint8List? fileBytes = file.bytes;
        if (fileBytes != null) {
          return {'binary': fileBytes, 'name': file.name};
        }
      }
    }

    throw Exception('Gagal mengambil bukti');
  }

  ImageProvider getImage() {
    if (isPaid) {
      return const AssetImage('assets/images/sukses.png');
    }

    if (bukti == null) {
      return const AssetImage('assets/images/white.png');
    } else {
      return MemoryImage(bukti?['binary']);
    }
  }

  void initSocket(BuildContext context) {
    clientSocket.on('on_change_status_order', (data) {
      if (data['status'] == "APPROVED" && this.data?['code'] == data['code']) {
        setCurrentNavigation(this.data?['id']).then((value) {
          Navigator.of(context).pushReplacementNamed('/map');
        });
      } else if (data['status'] == "REJECTED" &&
          this.data?['code'] == data['code']) {
        getStorage().then((value) {
          value.remove('navigation');
          Navigator.of(context).pushReplacementNamed('/history');
        });
      }
    });
  }

  @override
  void initState() {
    getToken().then((token) {
      if (token == null) {
        showUnAuthorizedError(context);
        Navigator.of(context).pushReplacementNamed('/');
        return;
      }

      getCurrentPayment().then((value) async {
        if (value == null) {
          Navigator.of(context).pushNamed('/history');
        } else {
          try {
            final response = await getDataPackage(value);
            setState(() {
              data = response;
              isPaid = response['payment']['payment_bill'] != null;
              preLoad = false;
            });
          } on DioException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message!),
                backgroundColor: const Color.fromARGB(255, 211, 65, 54),
              ),
            );
            Navigator.of(context).pop();
          }
        }
      });
    });

    super.initState();
    initSocket(context);
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
              Navigator.of(context).pushNamed('/history');
            },
            child: const Icon(
              Ionicons.chevron_back_outline,
              color: purpleChat,
            ),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      if (!isPaid) {
                        try {
                          final path = await pickImageFromGalery();
                          setState(() {
                            bukti = path;
                          });
                        } on Exception catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  const Color.fromARGB(255, 202, 70, 60),
                              content: Text(e.toString()),
                            ),
                          );
                        }
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
                            decoration: BoxDecoration(
                              image: DecorationImage(image: getImage()),
                            ),
                            child: Center(
                              child: Text(
                                isPaid ? "" : "Upload Pembayaran",
                                style: const TextStyle(color: mediumGreyColor),
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isPaid
                                  ? "Status Pembayaran"
                                  : "Transfer ke Bank BARI",
                              style: const TextStyle(
                                  fontSize: 10, color: whiteColor),
                            ),
                            Text(
                              isPaid ? data!['status'] : "2212143121312",
                              style: const TextStyle(
                                fontSize: 10,
                                color: whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Nama Paket",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              data?['package']['name'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Harga",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              formatRupiah(
                                double.parse(data?['package']['price']),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
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
                      !isPaid
                          ? Container(
                              margin: EdgeInsets.all(size.width * 0.02),
                              child: SizedBox(
                                width: size.width * 0.65,
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (bukti == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 202, 70, 60),
                                          content:
                                              Text('Upload terlebih dahulu'),
                                        ),
                                      );
                                    } else {
                                      uploadTransferBill(
                                        bukti!,
                                        encryptId(data?['id']),
                                      ).then((value) {
                                        setState(() {
                                          isPaid = true;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: greenPrimary,
                                            content: Text(
                                              'Success silah tunggu beberapa saat',
                                            ),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          18.0), // Adjust the value as needed
                                    ),
                                  ),
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
