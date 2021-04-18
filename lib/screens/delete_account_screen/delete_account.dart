// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/screens/delete_account_screen/body.dart';
import 'package:h4y_partner/screens/delete_account_screen/app_bar.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  // Text Field Variables
  String phoneNumber;
  String phoneIsoCode;
  String nonInternationalNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: DeleteAccountAppBar(),
      ),
      body: Body(
        phoneNumber: phoneNumber,
        phoneIsoCode: phoneIsoCode,
        nonInternationalNumber: nonInternationalNumber,
        onPhoneNumberChange: (
          String number,
          String internationalizedPhoneNumber,
          String isoCode,
        ) {
          setState(
            () {
              phoneNumber = internationalizedPhoneNumber;
              phoneIsoCode = isoCode;
              nonInternationalNumber = number;
            },
          );
        },
      ),
    );
  }
}
