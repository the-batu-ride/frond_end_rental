import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constant/colors.dart';

BottomNavigationBar bottomMenu() {
  return BottomNavigationBar(
    onTap: (value) {},
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
        label: 'Berita',
      ),
      BottomNavigationBarItem(
        icon: Icon(Ionicons.qr_code_outline),
        label: 'Scan QR',
      ),
      BottomNavigationBarItem(
        icon: Icon(Ionicons.notifications_outline),
        label: 'Notifikasi',
      ),
      BottomNavigationBarItem(
        icon: Icon(Ionicons.settings_outline),
        label: 'Setting',
      ),
    ],
  );
}
