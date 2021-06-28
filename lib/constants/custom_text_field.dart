// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final int maxLines;
  final Function validator;
  final Function onChanged;
  final dynamic initialValue;
  final String labelText;
  final String hintText;

  CustomTextField({
    @required this.keyboardType,
    this.maxLines,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(0xFF1C3857),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFF95989A),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Color(0xFF1C3857),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Color(0xFF1C3857),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
