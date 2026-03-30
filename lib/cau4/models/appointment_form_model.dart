import 'package:flutter/material.dart';

class AppointmentFormModel {
  final DateTime date;
  final TimeOfDay time;
  final String service;

  const AppointmentFormModel({
    required this.date,
    required this.time,
    required this.service,
  });
}
