import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/footer_custom.dart';

var data = [
  ["Packahe City Tour", "IDR 30.000", "IDR.30.000"],
  ["Packahe City Tour", "IDR 30.000", "IDR.30.000"],
  ["Packahe City Tour", "IDR 30.000", "IDR.30.000"]
];

// model json
// {
//   16/6/2023{
//     packag City Tour{
//       20.000
//       20.000
//     }
//   }
// }

class transaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appbarCustom("Transaction", Icons.notifications),
      body: footerCustom());
}
