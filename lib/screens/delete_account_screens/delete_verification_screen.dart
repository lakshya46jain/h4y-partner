// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/constants/signature_button.dart';

class DeleteAccVerificationScreen extends StatefulWidget {
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final String phoneNumber;
  final Function submitOTP;

  DeleteAccVerificationScreen({
    @required this.phoneIsoCode,
    @required this.nonInternationalNumber,
    @required this.phoneNumber,
    @required this.submitOTP,
  });

  @override
  _DeleteAccVerificationScreenState createState() =>
      _DeleteAccVerificationScreenState();
}

class _DeleteAccVerificationScreenState
    extends State<DeleteAccVerificationScreen> {
  // Text Field Variable
  String fullName;
  String occupation;
  String phoneIsoCode;
  String nonInternationalNumber;

  // Pin Input Declarations
  final _pinPutFocusNode = FocusNode();
  final _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(
      color: Color(0xFF95989A),
    ),
    borderRadius: BorderRadius.circular(15.0),
  );
  final BoxDecoration pinPutSelectedDecoration = BoxDecoration(
    border: Border.all(
      color: Color(0xFF1C3857),
    ),
    borderRadius: BorderRadius.circular(15.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: SignatureButton(type: "Back Button"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Enter the 6-digit OTP sent to",
                    style: TextStyle(
                      height: 1.0,
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      TextSpan(
                        text: "\n${widget.phoneNumber}",
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 24.0,
                          color: Colors.black,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                PinPut(
                  autofocus: true,
                  fieldsCount: 6,
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  eachFieldWidth: 55,
                  eachFieldHeight: 60,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutSelectedDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: widget.submitOTP,
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {
                    FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: widget.phoneNumber,
                      timeout: Duration(seconds: 120),
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {},
                      verificationFailed:
                          (FirebaseAuthException exception) async {
                        AuthService().verificationFailed(
                          exception,
                          context,
                        );
                      },
                      codeSent:
                          (String verificationId, int resendToken) async {},
                      codeAutoRetrievalTimeout: (String verificationId) async {
                        verificationId = verificationId;
                      },
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Didn't recieve the OTP?",
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: " Resend",
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 16.0,
                            color: Color(0xFF1C3857),
                            fontFamily: "BalooPaaji",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
