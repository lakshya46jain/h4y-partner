// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/constants/policy_dialog.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  final String? countryCode;
  final String? phoneIsoCode;
  final String? nonInternationalNumber;

  const PhoneAuthScreen({
    Key? key,
    required this.countryCode,
    required this.phoneIsoCode,
    required this.nonInternationalNumber,
  }) : super(key: key);

  @override
  PhoneAuthScreenState createState() => PhoneAuthScreenState();
}

class PhoneAuthScreenState extends State<PhoneAuthScreen> {
  // Text Field Variables
  String? countryCode;
  String? phoneIsoCode;
  String? nonInternationalNumber;

  @override
  void initState() {
    setState(() {
      phoneIsoCode = widget.phoneIsoCode;
      countryCode = widget.countryCode;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.chevron_left,
            size: 25.0,
            color: Color(0xFFFEA700),
          ),
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your mobile number",
                  style: GoogleFonts.balooPaaji2(
                    height: 1.3,
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                CustomFields(
                  type: "Phone",
                  autoFocus: true,
                  phoneIsoCode: widget.phoneIsoCode,
                  nonInternationalNumber: widget.nonInternationalNumber,
                  onChangedPhone: (phone) {
                    setState(() {
                      nonInternationalNumber = phone.number;
                    });
                  },
                  onCountryChanged: (phone) {
                    setState(() {
                      countryCode = phone.dialCode;
                      phoneIsoCode = phone.code;
                    });
                  },
                ),
                const SizedBox(height: 30.0),
                Text(
                  "By continuing, you agree to our",
                  style: GoogleFonts.balooPaaji2(
                    height: 1.0,
                    fontSize: 16.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const PolicyDialog(
                          mdFileName: 'terms_and_conditions.md',
                        );
                      },
                    );
                  },
                  child: Text(
                    "Terms & Conditions",
                    style: GoogleFonts.balooPaaji2(
                      height: 1.3,
                      fontSize: 16.0,
                      color: const Color(0xFF1C3857),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: SignatureButton(
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  if (countryCode!.contains("+")) {
                    countryCode = countryCode!.replaceAll("+", "");
                  }
                  await AuthService().phoneAuthentication(
                    "",
                    "",
                    countryCode,
                    phoneIsoCode,
                    nonInternationalNumber,
                    "+$countryCode$nonInternationalNumber",
                    "Registration",
                    context,
                  );
                },
                withIcon: true,
                text: "CONTINUE",
                icon: CupertinoIcons.chevron_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
