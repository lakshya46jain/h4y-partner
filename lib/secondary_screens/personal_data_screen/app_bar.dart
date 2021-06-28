// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/back_button.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';

class PersonalDataAppBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final File imageFile;

  PersonalDataAppBar({
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
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Text(
        "Personal Data",
        style: TextStyle(
          fontSize: 25.0,
          color: Color(0xFF1C3857),
          fontFamily: "BalooPaaji",
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        StreamBuilder(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserDataProfessional userData = snapshot.data;
            return IconButton(
              icon: Icon(
                FluentIcons.checkmark_24_filled,
                size: 24.0,
                color: Color(0xFFFEA700),
              ),
              onPressed: () async {
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
                      nonInternationalNumber ?? userData.nonInternationalNumber,
                    );
                    Navigator.pop(context);
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
            );
          },
        ),
      ],
    );
  }
}
