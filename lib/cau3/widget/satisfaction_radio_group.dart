import 'package:flutter/material.dart';

class SatisfactionRadioGroup extends StatelessWidget {
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const SatisfactionRadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: Column(
        children: const [
          _SatisfactionOption(value: 'Hai long', label: 'Hai long'),
          _SatisfactionOption(value: 'Binh thuong', label: 'Binh thuong'),
          _SatisfactionOption(value: 'Chua hai long', label: 'Chua hai long'),
        ],
      ),
    );
  }
}

class _SatisfactionOption extends StatelessWidget {
  final String value;
  final String label;

  const _SatisfactionOption({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: value,
      title: Text(label),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
