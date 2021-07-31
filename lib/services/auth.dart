// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/primary_screens/wrapper.dart';
import 'package:h4y_partner/constants/verification_container.dart';
import 'package:h4y_partner/secondary_screens/register_profile_screen/register_profile_screen.dart';

class AuthService {
  // Firebase Auth Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User Object Based on Firebase User
  Help4YouUser _userFromFirebase(User user) {
    return user != null ? Help4YouUser(uid: user.uid) : null;
  }

  // Authenticate User
  Stream<Help4YouUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
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
    if (kIsWeb) {
      // TODO: Add Firebase Phone Authentication for Web
    } else {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _auth.signInWithCredential(phoneAuthCredential).then(
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
                    builder: (context) => RegisterProfileScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          );
        },
        verificationFailed: (FirebaseAuthException exception) {
          return "Error";
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => VerificationContainer(
              text1: "",
              text2: "We have sent your code to $phoneNumber.",
              onSubmit: (pin) async {
                HapticFeedback.heavyImpact();
                FocusScope.of(context).unfocus();
                var credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: pin,
                );
                _auth.signInWithCredential(credential).then(
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
                          builder: (context) => RegisterProfileScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                );
              },
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
      );
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
