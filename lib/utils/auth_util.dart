import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';

void showUnAuthorizedError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('Login terlebih dahulu'),
    backgroundColor: Color.fromARGB(255, 211, 65, 54),
  ));
}

void showGeneralError(BuildContext context, String message) {
  renderAlert(context, const Color.fromARGB(255, 211, 65, 54), message);
}

void showSuccessMessage(BuildContext context, String message) {
  renderAlert(context, greenPrimary, message);
}

void renderAlert(BuildContext context, Color color, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
  ));
}
