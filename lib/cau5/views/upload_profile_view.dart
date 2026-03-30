import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/upload_profile_model.dart';
import '../utils/validators.dart';
import '../widget/file_picker_field.dart';

class UploadProfileView extends StatefulWidget {
  const UploadProfileView({super.key});

  @override
  State<UploadProfileView> createState() => _UploadProfileViewState();
}

class _UploadProfileViewState extends State<UploadProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  PlatformFile? _selectedFile;
  bool _confirmed = false;
  String? _fileError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    setState(() {
      _selectedFile = result.files.single;
      _fileError = null;
    });
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;

    setState(() {
      _fileError = _selectedFile == null ? 'Vui long upload CV cua ban!' : null;
    });

    if (!valid || _selectedFile == null || !_confirmed) {
      return;
    }

    final data = UploadProfileModel(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      fileName: _selectedFile!.name,
      confirmed: _confirmed,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Da nop ho so: ${data.fullName} - ${data.fileName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bai 5: Form upload ho so'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ho va ten',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => Validators.requiredField(v, 'ho va ten'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.email,
              ),
              const SizedBox(height: 12),
              FilePickerField(
                fileName: _selectedFile?.name,
                errorText: _fileError,
                onPick: _pickFile,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _confirmed,
                contentPadding: EdgeInsets.zero,
                onChanged: (v) {
                  setState(() {
                    _confirmed = v ?? false;
                  });
                },
                title: const Text('Toi xac nhan thong tin la chinh xac'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Nop Ho So'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
