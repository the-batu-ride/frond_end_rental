import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/auth/auth_bloc.dart';
import 'package:frond_end_rental/bloc/map/map_bloc.dart';
import 'package:frond_end_rental/bloc/package/package_bloc.dart';
import 'package:frond_end_rental/bloc/payment/payment_bloc.dart';
import 'package:frond_end_rental/bloc/transaction/creation/transaction_creation_bloc.dart';
import 'package:frond_end_rental/bloc/transaction/list/transaction_bloc.dart';
import 'package:frond_end_rental/router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckStatus())),
        BlocProvider(create: (context) => TransactionCreationBloc()),
        BlocProvider(create: (context) => PackageBloc()..add(PackageFetched())),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(create: (context) => MapBloc()),
        BlocProvider(
          create: (context) => TransactionBloc()..add(TransactionFetched()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedOut) {
            router.goNamed('login');
          }
          if (state is SignedIn && Uri.base.fragment == '/') {
            router.goNamed('home');
          }
        },
        child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            useMaterial3: true,
          ),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
