// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/constants/back_button.dart';
import 'package:h4y_partner/constants/policy_dialog.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/constants/phone_number_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Welcome!",
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
                    "Call for desired day to day services in just a few clicks.",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF95989A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.0,
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
                    onTap: () async {
                      print("$countryCode$nonInternationalNumber");
                      HapticFeedback.heavyImpact();
                      FocusScope.of(context).unfocus();
                      if (nonInternationalNumber == "") {
                        showCustomSnackBar(
                          context,
                          FluentIcons.warning_24_regular,
                          Colors.orange,
                          "Warning!",
                          "Please enter your phone number.",
                        );
                      } else {
                        dynamic result =
                            await AuthService().phoneAuthentication(
                          "",
                          "",
                          phoneIsoCode,
                          nonInternationalNumber,
                          "$countryCode$nonInternationalNumber",
                          context,
                        );
                        return result;
                      }
                    },
                    withIcon: true,
                    text: "CONTINUE",
                    icon: FluentIcons.arrow_right_24_filled,
                  ),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDialog(
                            mdFileName: 'terms_and_conditions.md',
                          );
                        },
                      );
                    },
                    child: Text(
                      "By continuing you confirm that you agree \nwith our Terms and Conditions",
                      style: TextStyle(
                        color: Color(0xFF95989A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
