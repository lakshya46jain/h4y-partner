// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class SignatureButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData icon;
  final bool withIcon;

  SignatureButton({
    @required this.onPressed,
    @required this.text,
    this.icon,
    @required this.withIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFF1C3857),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / (1792 / 120),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: (withIcon == true)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / (828 / 20),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
