// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:firebase_storage/firebase_storage.dart';
// File Imports
import 'package:h4y_partner/screens/wrapper.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/constants/signature_button.dart';

class RegistrationContinueButton extends StatelessWidget {
  final File imageFile;
  final Help4YouUser user;
  final UserDataProfessional userData;
  final GlobalKey<FormState> formKey;
  final String fullName;
  final String occupation;

  RegistrationContinueButton({
    @required this.imageFile,
    @required this.user,
    @required this.userData,
    @required this.formKey,
    @required this.fullName,
    @required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      child: SignatureButton(
        withIcon: true,
        text: "CONTINUE",
        icon: CupertinoIcons.chevron_right,
        onTap: () async {
          // Upload Picture to Firebase
          Future setProfilePicture() async {
            if (imageFile != null) {
              Reference firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child(("H4Y Profile Pictures/" + user.uid));
              UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
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
                userData.phoneNumber ?? userData.phoneNumber,
                userData.countryCode ?? userData.countryCode,
                userData.phoneIsoCode ?? userData.phoneIsoCode,
                userData.nonInternationalNumber ??
                    userData.nonInternationalNumber,
              );
              setProfilePicture().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Wrapper(),
                  ),
                ),
              );
            }
          } catch (error) {
            showCustomSnackBar(
              context,
              CupertinoIcons.exclamationmark_circle,
              Colors.red,
              "Error!",
              "Please try updating your profile later.",
            );
          }
        },
      ),
    );
  }
}
