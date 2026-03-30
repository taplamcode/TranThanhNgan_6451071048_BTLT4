import 'package:flutter/material.dart';

class MaritalStatusRadioGroup extends StatelessWidget {
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const MaritalStatusRadioGroup({
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
        children: [
          RadioListTile<String>(
            value: 'Doc than',
            title: const Text('Độc thân'),
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<String>(
            value: 'Ket hon',
            title: const Text('Kết hôn'),
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<String>(
            value: 'Ly hon',
            title: const Text('Ly hôn'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
