import 'package:flutter/material.dart';

import '../models/survey_form_model.dart';
import '../utils/validators.dart';
import '../widget/interest_checkbox_tile.dart';
import '../widget/satisfaction_radio_group.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();

  final List<String> _interestOptions = const [
    'Phim anh',
    'The thao',
    'Am nhac',
    'Du lich',
  ];

  final Set<String> _selectedInterests = <String>{};
  String _satisfactionLevel = 'Hai long';

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final data = SurveyFormModel(
      selectedInterests: _selectedInterests.toList(),
      satisfactionLevel: _satisfactionLevel,
      note: _noteController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Da gui: ${data.selectedInterests.length} so thich, ${data.satisfactionLevel}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Survey')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SO THICH (INTERESTS)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              FormField<Set<String>>(
                validator: Validators.selectedInterests,
                initialValue: _selectedInterests,
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._interestOptions.map((interest) {
                        return InterestCheckboxTile(
                          label: interest,
                          value: _selectedInterests.contains(interest),
                          onChanged: (checked) {
                            setState(() {
                              if (checked ?? false) {
                                _selectedInterests.add(interest);
                              } else {
                                _selectedInterests.remove(interest);
                              }
                            });
                            field.didChange(
                              Set<String>.from(_selectedInterests),
                            );
                          },
                        );
                      }),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            field.errorText ?? '',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'MUC DO HAI LONG (SATISFACTION LEVEL)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SatisfactionRadioGroup(
                groupValue: _satisfactionLevel,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _satisfactionLevel = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'GHI CHU THEM (ADDITIONAL NOTES)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Ghi chu them...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Gui khao sat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
