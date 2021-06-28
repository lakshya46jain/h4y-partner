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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F7),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 30.0,
                  color: Color(0xFF1C3857),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / (828 / 40),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "BalooPaaji",
                  color: Color(0xFF1C3857),
                ),
              ),
            ),
            Icon(
              FluentIcons.arrow_right_24_filled,
              color: Color(0xFFFEA700),
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
