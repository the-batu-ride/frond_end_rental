import 'package:flutter/material.dart';
import 'package:frond_end_rental/screens/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:frond_end_rental/transaction_vertification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      home: const HomePage(),
    );
  }
}
