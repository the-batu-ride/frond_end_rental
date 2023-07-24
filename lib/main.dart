import 'package:flutter/material.dart';
import 'package:frond_end_rental/provider/user_provider.dart';
import 'package:frond_end_rental/screens/daftar.dart';
import 'package:frond_end_rental/screens/home_screen.dart';
import 'package:frond_end_rental/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
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
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: const HomePage(),
      routes: {
        '/login': (context) => const Login(),
        '/daftar': (context) => Daftar()
      },
    );
  }
}
