// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/primary_screens/wrapper.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/secondary_screens/register_profile_screen/stream_builder.dart';

class Body extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final File imageFile;
  final String fullName;
  final String occupation;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final String phoneNumber;
  final Function onChanged1;
  final Function onChanged2;
  final Function onChanged3;
  final Function onPressed1;
  final Function onPressed2;

  Body({
    this.formKey,
    this.imageFile,
    this.fullName,
    this.occupation,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.phoneNumber,
    this.onChanged1,
    this.onChanged2,
    this.onChanged3,
    this.onPressed1,
    this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    // Get User from Provider Package
    final user = Provider.of<Help4YouUser>(context);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 20),
            ),
            Text(
              "Complete your details to continue",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 50),
            ),
            ProfileStreamBuilder(
              imageFile: imageFile,
              fullName: fullName,
              occupation: occupation,
              onChanged1: onChanged1,
              onChanged2: onChanged2,
              onChanged3: onChanged3,
              onPressed1: onPressed1,
              onPressed2: onPressed2,
            ),
            StreamBuilder(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                UserDataProfessional userData = snapshot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.5,
                  ),
                  child: SignatureButton(
                    text: "Continue",
                    icon: FluentIcons.arrow_right_24_regular,
                    onTap: () async {
                      // Upload Picture to Firebase
                      Future setProfilePicture() async {
                        if (imageFile != null) {
                          Reference firebaseStorageRef = FirebaseStorage
                              .instance
                              .ref()
                              .child(("H4Y Profile Pictures/" + user.uid));
                          UploadTask uploadTask =
                              firebaseStorageRef.putFile(imageFile);
                          await uploadTask;
                          String downloadAddress =
                              await firebaseStorageRef.getDownloadURL();
                          await DatabaseService(uid: user.uid)
                              .updateProfilePicture(downloadAddress);
                        } else {
                          await DatabaseService(uid: user.uid)
                              .updateProfilePicture(userData.profilePicture);
                        }
                      }

                      HapticFeedback.heavyImpact();
                      FocusScope.of(context).unfocus();
                      try {
                        if (formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            fullName ?? userData.fullName,
                            occupation ?? userData.occupation,
                            phoneNumber ?? userData.phoneNumber,
                            phoneIsoCode ?? userData.phoneIsoCode,
                            nonInternationalNumber ??
                                userData.nonInternationalNumber,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Wrapper(),
                            ),
                          );
                        }
                        setProfilePicture();
                      } catch (error) {
                        showCustomSnackBar(
                          context,
                          FluentIcons.error_circle_24_regular,
                          Colors.red,
                          "Error!",
                          "Please try updating your profile later.",
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
