import 'package:flutter/material.dart';

import '../views/appointment_view.dart';

class AppointmentApp extends StatelessWidget {
  const AppointmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dat lich hen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AppointmentView(),
    );
  }
}
