// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/screens/wrapper.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/screens/registration_screen/registration_screen.dart';
import 'package:h4y_partner/screens/onboarding_screen/components/verification_screen.dart';

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

// Phone Authentication
  Future phoneAuthentication(
    String fullName,
    String occupation,
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    BuildContext context,
  ) async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 180),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then(
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
                  builder: (context) => Wrapper(),
                ),
                (route) => false,
              );
            } else {
              await DatabaseService(uid: user.uid).updateUserData(
                fullName,
                occupation,
                phoneNumber,
                phoneIsoCode,
                nonInternationalNumber,
              );
              await DatabaseService(uid: user.uid).updateProfilePicture(
                "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Wrapper(),
                ),
                (route) => false,
              );
            }
          },
        );
      },
      verificationFailed: (FirebaseAuthException exception) async {
        if (exception.code == 'invalid-phone-number') {
          showCustomSnackBar(
            context,
            FluentIcons.error_circle_24_regular,
            Colors.red,
            "Error!",
            "Please enter a valid phone number.",
          );
        } else if (exception.code == 'too-many-requests') {
          showCustomSnackBar(
            context,
            FluentIcons.warning_24_regular,
            Colors.orange,
            "Warning!",
            "We have recieved too many requests from this number. Please try again later.",
          );
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
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
                          builder: (context) => Wrapper(),
                        ),
                        (route) => false,
                      );
                    } else {
                      await DatabaseService(uid: user.uid).updateUserData(
                        fullName,
                        occupation,
                        phoneNumber,
                        phoneIsoCode,
                        nonInternationalNumber,
                      );
                      await DatabaseService(uid: user.uid).updateProfilePicture(
                        "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                ).catchError(
                  (error) {
                    if (error.code == 'invalid-verification-code') {
                      showCustomSnackBar(
                        context,
                        FluentIcons.error_circle_24_regular,
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
