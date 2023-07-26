import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppBarCustom extends AppBar {
  final BuildContext context;
  final String path;

  AppBarCustom(String data, IconData? icon, this.context,
      {super.key, required this.path})
      : super(
          title: Text(data),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(icon)),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(path);
            },
            icon: const Icon(Ionicons.chevron_back_outline),
          ),
          elevation: 0,
        );
}
