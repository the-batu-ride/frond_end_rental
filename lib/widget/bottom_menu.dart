import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/transaction/creation/transaction_creation_bloc.dart';
import 'package:frond_end_rental/utils/auth_util.dart';
import 'package:frond_end_rental/widget/qr_code_scanner.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../constant/colors.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            context.goNamed('home');
            break;
          case 1:
            context.goNamed('history');
            break;
          case 2:
            showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Scan Bike'),
                content: QrCodeScannerBottomSheet(onDetect: (code) {
                  Navigator.pop(context, code.raw);
                }),
              ),
            ).then((value) {
              try {
                int newValue = int.parse(value ?? '');
                context
                    .read<TransactionCreationBloc>()
                    .add(SelectBike(selected: newValue));
                showModalBottomSheet(
                  context: context,
                  builder: (_) => const PakcageBottomSheet(),
                );
              } catch (e) {
                showGeneralError(context, 'Kode QR tidak valid!');
              }
            });
            break;
          default:
            context.goNamed('profile');
            break;
        }
      },
      currentIndex: 1,
      backgroundColor: whiteColor,
      selectedItemColor: purplekColor,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Ionicons.pie_chart_outline),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.document_text_outline),
          label: 'Transaction',
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.qr_code_outline),
          label: 'Scan QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.settings_outline),
          label: 'Setting',
        ),
      ],
    );
  }
}
