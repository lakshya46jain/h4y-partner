// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

showCustomSnackBar(
  BuildContext context,
  IconData icon,
  Color color,
  String title,
  String message,
) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 27,
          color: color,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: "$title ",
              style: TextStyle(
                fontSize: 17.0,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: message,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13.0),
    ),
    backgroundColor: Colors.white,
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
