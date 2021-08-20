// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl_phone_field/intl_phone_field.dart';
// File Imports

class PhoneNumberTextField extends StatelessWidget {
  final bool autoFocus;
  final FocusNode focusNode;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final Function onChanged;
  final Function onCountryChanged;

  PhoneNumberTextField({
    this.autoFocus,
    this.focusNode,
    @required this.phoneIsoCode,
    @required this.nonInternationalNumber,
    @required this.onChanged,
    @required this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      autofocus: autoFocus ?? false,
      focusNode: focusNode ?? FocusNode(),
      searchText: "Search Country Name",
      countryCodeTextColor: Color(0xFF1C3857),
      dropDownArrowColor: Color(0xFF1C3857),
      decoration: InputDecoration(
        hintText: 'Enter Phone Number...',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: BorderSide(
            color: Color(0xFF1C3857).withOpacity(0.5),
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
      onCountryChanged: onCountryChanged,
      initialCountryCode: phoneIsoCode,
      initialValue: nonInternationalNumber,
    );
  }
}
