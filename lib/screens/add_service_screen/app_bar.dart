// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/constants/back_button.dart';

class AddServiceAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Text(
        "Add Service",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
