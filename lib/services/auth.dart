// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/screens/wrapper.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/bottom_nav_bar.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/screens/update_num_verification.dart';
import 'package:h4y_partner/screens/registration_screen/registration_screen.dart';
import 'package:h4y_partner/screens/onboarding_screen/components/verification_screen.dart';
import 'package:h4y_partner/screens/delete_account_screens/delete_verification_screen.dart';

class AuthService {
  // Firebase Auth Instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Create User Object Based on Firebase User
  Help4YouUser _userFromFirebase(User user) {
    return user != null ? Help4YouUser(uid: user.uid) : null;
  }

  // Authenticate User
  Stream<Help4YouUser> get user {
    return auth.authStateChanges().map(_userFromFirebase);
  }

  // Firebase Authentication Exception Future Function
  Future<void> verificationFailed(
    FirebaseAuthException exception,
    BuildContext context,
  ) async {
    if (exception.code == 'invalid-phone-number') {
      showCustomSnackBar(
        context,
        CupertinoIcons.exclamationmark_circle,
        Colors.red,
        "Error!",
        "Please enter a valid phone number.",
      );
    } else if (exception.code == 'too-many-requests') {
      showCustomSnackBar(
        context,
        CupertinoIcons.exclamationmark_triangle,
        Colors.orange,
        "Warning!",
        "We have recieved too many requests from this number. Please try again later.",
      );
    }
  }

  // Phone Authentication
  Future phoneAuthentication(
    String fullName,
    String occupation,
    String countryCode,
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    String motive,
    BuildContext context,
  ) async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException exception) async {
        verificationFailed(exception, context);
      },
      codeSent: (String verificationId, int resendToken) async {
        if (motive == "Registration") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
                phoneNumber: phoneNumber,
                submitOTP: (pin) {
                  HapticFeedback.heavyImpact();
                  var credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: pin,
                  );
                  auth.signInWithCredential(credential).then(
                    (UserCredential result) async {
                      User user = result.user;
                      DocumentSnapshot ds = await FirebaseFirestore.instance
                          .collection("H4Y Users Database")
                          .doc(user.uid)
                          .get();
                      if (ds.exists) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Wrapper(),
                          ),
                          (route) => false,
                        );
                      } else {
                        await DatabaseService(uid: user.uid).updateUserData(
                          fullName,
                          occupation,
                          phoneNumber,
                          countryCode,
                          phoneIsoCode,
                          nonInternationalNumber,
                        );
                        await DatabaseService(uid: user.uid)
                            .updateProfilePicture(
                              "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
                            )
                            .then(
                              (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen(),
                                ),
                                (route) => false,
                              ),
                            );
                      }
                    },
                  ).catchError(
                    (error) {
                      if (error.code == 'invalid-verification-code') {
                        showCustomSnackBar(
                          context,
                          CupertinoIcons.exclamationmark_circle,
                          Colors.red,
                          "Error!",
                          "Invalid verification code entered. Please try again later.",
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        } else if (motive == "Delete Account") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeleteAccVerificationScreen(
                phoneNumber: phoneNumber,
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
                submitOTP: (pin) {
                  HapticFeedback.heavyImpact();
                  PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: pin,
                  );
                  auth.currentUser.delete();
                  signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Wrapper(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          );
        } else if (motive == "Update Phone Number") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateNumVerificationScreen(
                phoneNumber: phoneNumber,
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
                submitOTP: (pin) async {
                  var phoneCredential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: pin,
                  );
                  await auth.currentUser
                      .updatePhoneNumber(phoneCredential)
                      .catchError(
                    (error) {
                      if (error.code == 'invalid-verification-code') {
                        showCustomSnackBar(
                          context,
                          CupertinoIcons.exclamationmark_circle,
                          Colors.red,
                          "Error!",
                          "Invalid verification code entered. Please try again later.",
                        );
                      }
                    },
                  ).then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                      (route) => false,
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        verificationId = verificationId;
      },
    );
  }

  // Sign Out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
