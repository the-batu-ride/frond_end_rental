import 'package:flutter/material.dart';
import 'package:frond_end_rental/item/appbar_custom.dart';

class transactionDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context)=> Scaffold(
appBar: appbarCustom("Transaction Detail", Icons.delete),
  );
}