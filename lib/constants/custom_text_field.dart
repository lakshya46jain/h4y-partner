// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl_phone_field/intl_phone_field.dart';
// File Imports

class CustomFields extends StatelessWidget {
  final TextInputType keyboardType;
  final int maxLines;
  final Function validator;
  final Function onChanged; // Common
  final dynamic initialValue;
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final String type;
  // Phone Number Field Variables
  final bool autoFocus;
  final FocusNode focusNode;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final Function onCountryChanged;

  CustomFields({
    this.keyboardType,
    this.maxLines,
    this.validator,
    this.onChanged, // Common
    this.initialValue,
    this.hintText,
    this.obscureText,
    this.readOnly,
    @required this.type,
    // Phone Number Field Variables
    this.autoFocus,
    this.focusNode,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return (type == "Normal")
        ? TextFormField(
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0xFF95989A),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.all(20.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Color(0xFF1C3857).withOpacity(0.5),
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
          )
        : (type == "Phone")
            ? IntlPhoneField(
                autofocus: autoFocus ?? false,
                focusNode: focusNode ?? FocusNode(),
                searchText: "Search Country Name",
                countryCodeTextColor: Color(0xFF1C3857),
                dropDownIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF1C3857),
                ),
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
              )
            : Container();
  }
}
