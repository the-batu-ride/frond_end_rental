import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/footer_custom.dart';

var data = [
  ["Packahe City Tour", "IDR 30.000", "IDR.30.000"],
  ["Packahe City Tour", "IDR 30.000", "IDR.30.000"],
  ["Packahe City Tour", "IDR 30.000", "IDR.30.000"]
];

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom("Transaction", Icons.notifications),
      body: footerCustom(),
    );
  }
}
