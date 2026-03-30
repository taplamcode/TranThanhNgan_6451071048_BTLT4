import 'package:flutter/material.dart';

import '../views/upload_profile_view.dart';

class UploadProfileApp extends StatelessWidget {
  const UploadProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form upload ho so',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const UploadProfileView(),
    );
  }
}
