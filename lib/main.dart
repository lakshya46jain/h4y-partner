// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:firebase_core/firebase_core.dart';
// File Imports
import 'package:h4y_partner/screens/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
