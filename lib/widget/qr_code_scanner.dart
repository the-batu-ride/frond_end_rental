import 'package:flutter/material.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';

class QrCodeScannerBottomSheet extends StatelessWidget {
  final Function(QRCodeCapture) onDetect;

  const QrCodeScannerBottomSheet({super.key, required this.onDetect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: QRCodeReaderSquareWidget(
        onDetect: onDetect,
        size: 250,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
