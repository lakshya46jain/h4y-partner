// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:international_phone_input/international_phone_input.dart';
// File Imports

// TODO: Use a international phone input with search country code
class PhoneNumberTextField extends StatelessWidget {
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final Function onPhoneNumberChange;
  PhoneNumberTextField({
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.onPhoneNumberChange,
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneInput(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintText: 'Phone Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      onPhoneNumberChange: onPhoneNumberChange,
      initialPhoneNumber: nonInternationalNumber,
      initialSelection: phoneIsoCode,
      showCountryCodes: true,
      showCountryFlags: true,
    );
  }
}
