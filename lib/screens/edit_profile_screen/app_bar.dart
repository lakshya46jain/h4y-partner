// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';

class EditProfileBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final File imageFile;

  EditProfileBar({
    this.formKey,
    this.fullName,
    this.occupation,
    this.phoneNumber,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    // Get User from Provider Package
    final user = Provider.of<Help4YouUser>(context);

    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        "My Profile",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      actions: [
        StreamBuilder<UserDataProfessional>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserDataProfessional userData = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(14.5),
              child: GestureDetector(
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  // Upload Picture to Firebase
                  Future setProfilePicture() async {
                    if (imageFile != null) {
                      Reference firebaseStorageRef = FirebaseStorage.instance
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
                      Navigator.pop(context);
                    }
                    setProfilePicture();
                  } catch (error) {
                    showCustomSnackBar(
                      context,
                      FluentIcons.error_circle_24_regular,
                      Colors.white,
                      "There was an error updating your profile. Please try again later.",
                      Colors.white,
                      Colors.red,
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
