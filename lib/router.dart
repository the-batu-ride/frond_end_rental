import 'package:frond_end_rental/screens/daftar.dart';
import 'package:frond_end_rental/screens/home_screen.dart';
import 'package:frond_end_rental/screens/list_transaksi.dart';
import 'package:frond_end_rental/screens/login_screen.dart';
import 'package:frond_end_rental/screens/map_screen.dart';
import 'package:frond_end_rental/screens/profile_screen.dart';
import 'package:frond_end_rental/screens/transaction_detail_screen.dart';
import 'package:frond_end_rental/screens/transaction_vertification_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (_, __) => const Login(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: '/daftar',
      name: 'daftar',
      builder: (_, __) => const Daftar(),
    ),
    GoRoute(
      path: '/history',
      name: 'history',
      builder: (_, __) => const ListTransaksi(),
    ),
    GoRoute(
      path: '/transaction/:code',
      name: 'detail',
      builder: (_, state) => TransactionDetail(
        code: state.pathParameters['code']!,
      ),
    ),
    GoRoute(
      path: '/transaction/:code/verification',
      name: 'verification',
      builder: (_, state) {
        return TransactionVerification(
          code: state.pathParameters['code']!,
        );
      },
    ),
    GoRoute(
      path: '/transaction/:code/route',
      name: 'route',
      builder: (_, state) => MapScreen(
        code: state.pathParameters['code']!,
      ),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (_, __) => const ProfileScreen(),
    ),
  ],
  routerNeglect: true,
);
