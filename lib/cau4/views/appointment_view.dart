import 'package:flutter/material.dart';

import '../models/appointment_form_model.dart';
import '../utils/validators.dart';
import '../widget/picker_field.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _service = 'Kiểm tra tổng quát';
  bool _submitted = false;

  final List<String> _services = const [
    'Kiểm tra tổng quát',
    'Dịch vụ 2',
    'Dịch vụ 3',
  ];

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initialDate = _selectedDate ?? now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedDate = picked;
      _dateController.text = _formatDate(picked);
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedTime = picked;
      _timeController.text = picked.format(context);
    });
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final dateError = Validators.dateNotInPast(_selectedDate);
    if (dateError != null) {
      return;
    }

    final date = _selectedDate;
    final time = _selectedTime;
    if (date == null || time == null) {
      return;
    }

    final data = AppointmentFormModel(
      date: date,
      time: time,
      service: _service,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã đặt lịch: ${_formatDate(data.date)} - ${data.time.format(context)} - ${data.service}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('ĐẶT LỊCH HẸN')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickerField(
                label: 'Chọn ngày',
                hint: 'Select Date',
                controller: _dateController,
                onTap: _pickDate,
                suffixIcon: const Icon(Icons.calendar_today),
                errorText: _submitted
                    ? Validators.dateNotInPast(_selectedDate)
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _timeController,
                readOnly: true,
                onTap: _pickTime,
                validator: (_) => Validators.requiredTime(_timeController.text),
                decoration: const InputDecoration(
                  labelText: 'Chọn giờ',
                  hintText: 'Chọn giờ',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _service,
                decoration: const InputDecoration(
                  labelText: 'Chọn dịch vụ',
                  border: OutlineInputBorder(),
                ),
                items: _services
                    .map(
                      (service) => DropdownMenuItem<String>(
                        value: service,
                        child: Text(service),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _service = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Xác nhận đặt lịch'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
