// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/primary_screens/services_screen/body.dart';
import 'package:h4y_partner/secondary_screens/add_service_screen/add_service.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Body(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            FluentIcons.add_28_filled,
            color: Colors.white,
            size: 28.0,
          ),
          backgroundColor: Color(0xFF1C3857),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddServiceScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
