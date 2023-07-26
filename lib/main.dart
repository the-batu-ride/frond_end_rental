import 'package:flutter/material.dart';
import 'package:frond_end_rental/provider/transaction_provider.dart';
import 'package:frond_end_rental/provider/user_provider.dart';
import 'package:frond_end_rental/screens/daftar.dart';
import 'package:frond_end_rental/screens/home_screen.dart';
import 'package:frond_end_rental/screens/list_transaksi.dart';
import 'package:frond_end_rental/screens/login_screen.dart';
import 'package:frond_end_rental/screens/map_screen.dart';
import 'package:frond_end_rental/screens/profile_screen.dart';
import 'package:frond_end_rental/screens/transaction_detail_screen.dart';
import 'package:frond_end_rental/screens/transaction_vertification_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider<TransactionProvider>(
        create: (_) => TransactionProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/daftar': (context) => Daftar(),
        '/detail-transaction': (context) => const TransactionDetail(),
        '/verification': (context) => const TransactionVerification(),
        '/map': (context) => const MapScreen(),
        '/history': (context) => const ListTransaksi(),
        '/profile': (context) => const ProfileScreen()
      },
    );
  }
}
