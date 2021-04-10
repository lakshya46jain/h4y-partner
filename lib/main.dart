// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),

      // Firebase Builder
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text("Error"),
            ),
          );
        }

        // Show Application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<Help4YouUser>.value(
            initialData: Help4YouUser(),
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: WelcomeScreen(),
            ),
          );
        }

        // Initialization
        return Container(
          child: Center(
            child: Text("Initializing"),
          ),
        );
      },
    );
  }
}
