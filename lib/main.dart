import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
