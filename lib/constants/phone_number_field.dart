// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl_phone_field/intl_phone_field.dart';
// File Imports

class PhoneNumberTextField extends StatelessWidget {
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final Function onChanged;

  PhoneNumberTextField({
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      countryCodeTextColor: Color(0xFF1C3857),
      dropDownArrowColor: Color(0xFF1C3857),
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: TextStyle(
          color: Color(0xFF1C3857),
        ),
        hintText: 'Phone Number',
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
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      onChanged: onChanged,
      initialCountryCode: phoneIsoCode,
      initialValue: nonInternationalNumber,
    );
  }
}
