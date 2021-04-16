// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class ExpandedButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String text;
  ExpandedButton({
    this.onPressed,
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 7.5,
        horizontal: 10.0,
      ),
      child: MaterialButton(
        padding: EdgeInsets.all(0.0),
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFF5F6F9),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30.0,
                color: Colors.deepOrange,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / (828 / 40),
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Icon(
                FluentIcons.arrow_right_24_regular,
                color: Colors.black,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
