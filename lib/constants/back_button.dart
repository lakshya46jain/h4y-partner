// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.left_chevron,
        size: 25.0,
        color: Color(0xFFFEA700),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
