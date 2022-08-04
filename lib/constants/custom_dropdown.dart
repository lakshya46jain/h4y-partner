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
  final String hintText;

  const CustomDropdown({
    Key key,
    this.items,
    this.onChanged,
    this.validator,
    this.icon,
    this.value,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      validator: validator,
      icon: Icon(
        icon,
        color: const Color(0xFF1C3857),
        size: 20.0,
      ),
      value: value,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xFF1C3857)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xFF1C3857)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
