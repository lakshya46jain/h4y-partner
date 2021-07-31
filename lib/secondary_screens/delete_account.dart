// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/constants/back_button.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/constants/phone_number_field.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  // Text Field Variables
  String countryCode;
  String phoneIsoCode;
  String nonInternationalNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Delete Account",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "We are sad to see you go.",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF95989A),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 45.0,
              ),
              PhoneNumberTextField(
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
                onChanged: (phone) {
                  setState(() {
                    nonInternationalNumber = phone.number;
                  });
                },
                onCountryChanged: (phone) {
                  setState(() {
                    countryCode = phone.countryCode;
                    phoneIsoCode = phone.countryISOCode;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              SignatureButton(
                onTap: () {},
                withIcon: true,
                text: "CONTINUE",
                icon: FluentIcons.arrow_right_24_filled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
