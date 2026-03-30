import 'package:flutter/material.dart';

class AppLabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;

  const AppLabeledTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
