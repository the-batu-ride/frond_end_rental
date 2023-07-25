import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';

class ButtonSolid extends StatelessWidget {
  final Size sizes;
  final String text;
  final Function()? handler;

  const ButtonSolid({
    super.key,
    required this.sizes,
    required this.text,
    this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: handler,
      style: TextButton.styleFrom(
        fixedSize: Size(
          sizes.width - 32,
          sizes.height * (0.06),
        ),
        backgroundColor: greenPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
