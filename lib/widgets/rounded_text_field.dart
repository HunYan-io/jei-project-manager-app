import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String? labelText;
  final String? errorText;
  final TextEditingController? controller;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  const RoundedTextField({
    Key? key,
    this.labelText,
    this.controller,
    this.errorText,
    this.obscureText = false,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        contentPadding: const EdgeInsets.fromLTRB(25, 24, 25, 16),
      ),
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
    );
  }
}
