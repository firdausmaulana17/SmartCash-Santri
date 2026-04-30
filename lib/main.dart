import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SmartCashSantriApp());
}

class SmartCashSantriApp extends StatelessWidget {
  const SmartCashSantriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartCash Santri',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),
    );
  }
}
