import 'package:flutter/material.dart';

import '../models/personal_info_model.dart';
import '../utils/validators.dart';
import '../widget/app_labeled_text_field.dart';
import '../widget/marital_status_radio_group.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String _gender = 'Nam';
  String _maritalStatus = 'Ket hon';
  double _income = 15;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  bool get _isSubmitEnabled {
    final nameError = Validators.requiredField(
      _nameController.text,
      'ho va ten',
    );
    final ageError = Validators.age(_ageController.text);
    return nameError == null && ageError == null;
  }

  void _submit() {
    if (!_isSubmitEnabled) {
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final data = PersonalInfoModel(
      fullName: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      gender: _gender,
      maritalStatus: _maritalStatus,
      income: _income,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Da luu: ${data.fullName}, ${data.age} tuoi, ${data.gender}, ${data.maritalStatus}, ${data.income.toStringAsFixed(0)} tr VND',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM THONG TIN CA NHAN'),
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
              AppLabeledTextField(
                controller: _nameController,
                label: 'Ho va ten',
                hint: 'Nhap ten cua ban',
                validator: (value) =>
                    Validators.requiredField(value, 'ho va ten'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              AppLabeledTextField(
                controller: _ageController,
                label: 'Tuoi',
                hint: 'Nhap tuoi cua ban',
                keyboardType: TextInputType.number,
                validator: Validators.age,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _gender,
                decoration: const InputDecoration(
                  labelText: 'Gioi tinh',
                  border: UnderlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                  DropdownMenuItem(value: 'Nu', child: Text('Nu')),
                  DropdownMenuItem(value: 'Khac', child: Text('Khac')),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              const Text(
                'Tinh trang hon nhan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              MaritalStatusRadioGroup(
                groupValue: _maritalStatus,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _maritalStatus = value;
                  });
                },
              ),
              const SizedBox(height: 4),
              const Text(
                'Muc thu nhap',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Center(
                child: Text(
                  'Muc: ${_income.toStringAsFixed(0)} tr VND',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Slider(
                value: _income,
                min: 0,
                max: 30,
                divisions: 30,
                label: '${_income.toStringAsFixed(0)} tr VND',
                onChanged: (value) {
                  setState(() {
                    _income = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitEnabled ? _submit : null,
                  child: const Text('Luu thong tin'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
