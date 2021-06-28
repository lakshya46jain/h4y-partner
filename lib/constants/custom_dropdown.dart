// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final Function onChanged;
  final Function validator;
  final IconData icon;
  final dynamic value;
  final String labelText;
  final String hintText;

  CustomDropdown({
    this.items,
    this.onChanged,
    this.validator,
    this.icon,
    this.value,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      validator: validator,
      icon: Icon(
        icon,
        color: Colors.grey,
        size: 20.0,
      ),
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(0xFF1C3857),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(
            color: Color(0xFF1C3857),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(
            color: Color(0xFF1C3857),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
