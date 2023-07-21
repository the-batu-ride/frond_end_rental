import 'package:flutter/material.dart';

import '../constant/colors.dart';

BottomNavigationBar BottomMenu() {
  var darkmode = true;
  var color = darkmode == true ? Colors.white:Colors.black;
  return BottomNavigationBar(
    backgroundColor: darkpurpleColor,
    unselectedItemColor: color,
    type: BottomNavigationBarType.fixed,
    items:  <BottomNavigationBarItem>[
      BottomNavigationBarItem(
      
        icon: Icon(Icons.pie_chart_outline_rounded ,color: 
        
        color
        ),
        label: 'Home' ,
      ),
      BottomNavigationBarItem(
       backgroundColor: color,
        icon: Icon(Icons.article_outlined,color: 
       color),
        label: 'Berita',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code,color: color),
        label: 'Scan QR',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications_outlined,color: color),
        label: ('Notifikasi'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined,color: color),
        label: 'Setting',
      ),
    ],
  );
}
