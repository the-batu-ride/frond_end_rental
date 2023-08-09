import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart' show Ionicons;

class AppBarCustom extends AppBar {
  final BuildContext context;
  final String path;

  AppBarCustom(String data, IconData? icon, this.context,
      {super.key, required this.path})
      : super(
          title: Text(data),
          centerTitle: true,
          actions: [
            icon == null
                ? const SizedBox()
                : IconButton(
                    onPressed: () {},
                    icon: Icon(icon),
                  ),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => context.goNamed(path),
            icon: const Icon(Ionicons.chevron_back_outline),
          ),
          elevation: 0,
        );
}
