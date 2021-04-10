// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class DashboardAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Dashboard",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
