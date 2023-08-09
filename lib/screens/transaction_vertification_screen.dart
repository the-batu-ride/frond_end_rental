import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/payment/payment_bloc.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/utils/auth_util.dart';
import 'package:frond_end_rental/utils/format.dart';
import 'package:frond_end_rental/utils/http.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/loader.dart' show CenterLoader;
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TransactionVerification extends StatefulWidget {
  final String code;

  const TransactionVerification({super.key, required this.code});

  @override
  State<TransactionVerification> createState() =>
      _TransactionVerificationState();
}

class _TransactionVerificationState extends State<TransactionVerification> {
  final clientSocket = io(socketServer).connect();

  Future<dynamic> pickImageFromGalery(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      if (result.files.isNotEmpty) {
        final file = result.files.single;
        final Uint8List? fileBytes = file.bytes;
        if (fileBytes != null) {
          if (context.mounted) {
            context
                .read<PaymentBloc>()
                .add(UploadPayment(name: file.name, bynary: fileBytes));
          }
        }
      }
    }
  }

  ImageProvider getImage(dynamic bukti, bool isPaid) {
    if (isPaid) {
      return const AssetImage('assets/images/sukses.png');
    }

    if (bukti == null) {
      return const AssetImage('assets/images/white.png');
    } else {
      return MemoryImage(bukti);
    }
  }

  void initSocket(BuildContext context) {
    clientSocket.on('on_change_status_order', (data) {
      context
          .read<PaymentBloc>()
          .add(UpdateStatus(status: data['status'], code: data['code']));
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(Load(decryptId(widget.code)));
    initSocket(context);
  }

  @override
  void dispose() {
    clientSocket.dispose();
    super.dispose();
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
            onTap: () => context.goNamed('history'),
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
              'Transactions Verification',
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
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state.status == PaymentStatus.initial) {
            return const CenterLoader();
          }

          if (state.status == PaymentStatus.error) {
            return Center(
              child: Text(state.error ?? 'Terjadi kesalahan'),
            );
          }

          return BlocListener<PaymentBloc, PaymentState>(
            listener: (context, listen) {
              if (listen.transaction!.isApproved) {
                final code = encryptId(listen.transaction!.id);
                context.goNamed('route', pathParameters: {'code': code});
              }

              if (listen.transaction!.isRejected) {
                context.goNamed('history');
              }

              if (listen.status == PaymentStatus.success) {
                showSuccessMessage(context, 'Success upload bukti pembayaran');
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.width * 0.05,
                  ),
                  GestureDetector(
                    onTap: () => pickImageFromGalery(context),
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
                              image: DecorationImage(
                                image: getImage(
                                  state.bynary,
                                  state.transaction!.isPaid,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.bynary != null ||
                                        state.transaction!.isPaid
                                    ? ''
                                    : 'Upload Pembayaran',
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
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: size.width * .65,
                    decoration: BoxDecoration(
                      color: purpleChat,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.transaction!.isPaid
                                  ? 'Status Pembayaran'
                                  : 'Transfer ke Bank BRI',
                              style: const TextStyle(
                                fontSize: 10,
                                color: whiteColor,
                              ),
                            ),
                            Text(
                              state.transaction!.isPaid
                                  ? state.transaction!.status
                                  : '2212143121312',
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
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: size.width * .65,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Nama Paket',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              state.transaction!.package.name,
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
                              'Harga',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              formatRupiah(
                                double.parse(state.transaction!.package.price),
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
                      !state.transaction!.isPaid
                          ? Container(
                              margin: EdgeInsets.all(size.width * 0.02),
                              child: SizedBox(
                                width: size.width * 0.65,
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () => context
                                      .read<PaymentBloc>()
                                      .add(SavePayment()),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Upload',
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
        },
      ),
    );
  }
}
