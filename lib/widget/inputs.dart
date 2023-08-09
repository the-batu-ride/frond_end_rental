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

class BaseInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hint, label;
  final bool secure;

  const BaseInput({
    super.key,
    this.controller,
    this.secure = false,
    required this.hint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: secure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class InputWithValidate extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final bool secure;
  final List<dynamic> validation;

  const InputWithValidate({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.secure = false,
    this.validation = const <dynamic>[],
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: secure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        for (var i = 0; i < validation.length; i++) {
          if (value == validation[i]) {
            return 'Kolom ini wajib diisi!';
          }

          if (value != null &&
              validation[i].runtimeType == int &&
              value.length < validation[i]) {
            return 'Panjang minimal ${validation[i]} karakter!';
          }
        }

        return null;
      },
    );
  }
}
