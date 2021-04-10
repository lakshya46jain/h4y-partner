// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

showCustomSnackBar(
  BuildContext context,
  IconData icon,
  Color iconColor,
  String message,
  Color textColor,
  Color backgroundColor,
) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: iconColor,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / (828 / 30),
        ),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
            ),
          ),
        ),
      ],
    ),
    elevation: 0.0,
    backgroundColor: backgroundColor,
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
