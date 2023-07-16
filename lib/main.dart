import 'package:flutter/material.dart';
import 'package:frond_end_rental/transaction.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: transaction(),
    );
  }
}