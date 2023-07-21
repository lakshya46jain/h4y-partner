// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// File Imports

class CustomFields extends StatelessWidget {
  final TextInputType? keyboardType;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function(PhoneNumber)? onChangedPhone;
  final dynamic initialValue;
  final String? hintText;
  final bool? obscureText;
  final bool? readOnly;
  final String? type;
  // Phone Number Field Variables
  final bool? autoFocus;
  final FocusNode? focusNode;
  final String? phoneIsoCode;
  final String? nonInternationalNumber;
  final Function(Country)? onCountryChanged;

  const CustomFields({
    Key? key,
    this.keyboardType,
    this.maxLines,
    this.validator,
    this.onChanged,
    this.onChangedPhone,
    this.initialValue,
    this.hintText,
    this.obscureText,
    this.readOnly,
    required this.type,
    // Phone Number Field Variables
    this.autoFocus,
    this.focusNode,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.onCountryChanged,
  }) : super(key: key);

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
              hintStyle: const TextStyle(
                color: Color(0xFF95989A),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.all(20.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: const Color(0xFF1C3857).withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Color(0xFF1C3857),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          )
        : (type == "Phone")
            ? IntlPhoneField(
                autofocus: autoFocus ?? false,
                focusNode: focusNode ?? FocusNode(),
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number...',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 20.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: const Color(0xFF1C3857).withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF1C3857),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: onChangedPhone,
                onCountryChanged: onCountryChanged,
                initialCountryCode: phoneIsoCode,
                initialValue: nonInternationalNumber,
              )
            : Container();
  }
}
