import 'package:flutter/material.dart';

class FilePickerField extends StatelessWidget {
  final String? fileName;
  final String? errorText;
  final VoidCallback onPick;

  const FilePickerField({
    super.key,
    required this.fileName,
    required this.errorText,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('File Picker', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        OutlinedButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.upload_file),
          label: Text(fileName == null ? 'Chon Tep CV' : fileName!),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
