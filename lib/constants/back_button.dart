// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FluentIcons.arrow_left_24_filled,
        size: 25.0,
        color: Color(0xFFFEA700),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
