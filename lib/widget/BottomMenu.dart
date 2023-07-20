import 'package:flutter/material.dart';

import '../constant/colors.dart';

BottomNavigationBar BottomMenu() {
  return BottomNavigationBar(
    backgroundColor: darkpurpleColor,
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.pie_chart_outline_rounded),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.article_outlined),
        label: 'Berita',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code),
        label: 'Scan QR',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications_outlined),
        label: 'Notifikasi',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined),
        label: 'Setting',
      ),
    ],
  );
}
