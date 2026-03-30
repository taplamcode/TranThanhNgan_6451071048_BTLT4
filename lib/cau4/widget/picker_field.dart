import 'package:flutter/material.dart';

class PickerField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? errorText;
  final Widget? suffixIcon;

  const PickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.onTap,
    this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
