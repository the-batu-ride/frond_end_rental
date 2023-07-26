import 'package:flutter/material.dart';

void showUnAuthorizedError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('Login terlebih dahulu'),
    backgroundColor: Color.fromARGB(255, 211, 65, 54),
  ));
}

void showGeneralError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: const Color.fromARGB(255, 211, 65, 54),
  ));
}
