import 'package:api_user/list_dosen.dart/splash_screen.dart';

// import 'package:api_user/uiview/list_user_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Dosen App',
      home: const SplashScreenPage(),
    );
  }
}
