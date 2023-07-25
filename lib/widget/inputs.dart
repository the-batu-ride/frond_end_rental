import 'package:flutter/material.dart';

class GeneralInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Icon? icon;
  final bool? secure;
  final TextInputAction? action;
  final Widget? customInput;
  final Function(String)? onTyping;

  const GeneralInput({
    super.key,
    this.controller,
    this.hint,
    this.icon,
    this.action,
    this.customInput,
    this.secure,
    this.onTyping,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: customInput ??
            TextField(
              controller: controller,
              textInputAction: action,
              obscureText: secure ?? false,
              decoration: InputDecoration(
                icon: icon,
                border: InputBorder.none,
                hintText: hint,
                fillColor: const Color.fromARGB(255, 194, 194, 194),
              ),
              onSubmitted: onTyping,
            ),
      ),
    );
  }
}
