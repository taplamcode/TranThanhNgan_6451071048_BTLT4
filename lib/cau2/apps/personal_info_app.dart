import 'package:flutter/material.dart';

import '../views/personal_info_view.dart';

class PersonalInfoApp extends StatelessWidget {
  const PersonalInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form thong tin ca nhan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PersonalInfoView(),
    );
  }
}
