// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/screens/services_screen/body.dart';
import 'package:h4y_partner/screens/services_screen/app_bar.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: ServicesAppBar(),
      ),
      body: Body(),
    );
  }
}
