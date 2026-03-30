import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: null,
        ),
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
