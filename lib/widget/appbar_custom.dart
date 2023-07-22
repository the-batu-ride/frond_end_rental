import 'package:flutter/material.dart';

class AppBarCustom extends AppBar {
  AppBarCustom(String data, IconData? icon, {super.key})
      : super(
          title: Text(data),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(icon)),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          elevation: 0,
        );
}
