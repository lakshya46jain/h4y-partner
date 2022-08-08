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

class RegistrationContinueButton extends StatefulWidget {
  final File imageFile;
  final Help4YouUser user;
  final UserDataProfessional userData;
  final GlobalKey<FormState> formKey;
  final String fullName;
  final String occupation;

  const RegistrationContinueButton({
    Key key,
    @required this.imageFile,
    @required this.user,
    @required this.userData,
    @required this.formKey,
    @required this.fullName,
    @required this.occupation,
  }) : super(key: key);

  @override
  State<RegistrationContinueButton> createState() =>
      _RegistrationContinueButtonState();
}

class _RegistrationContinueButtonState
    extends State<RegistrationContinueButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
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
            if (widget.imageFile != null) {
              Reference firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child(("H4Y Profile Pictures/${widget.user.uid}"));
              UploadTask uploadTask =
                  firebaseStorageRef.putFile(widget.imageFile);
              await uploadTask;
              String downloadAddress =
                  await firebaseStorageRef.getDownloadURL();
              await DatabaseService(uid: widget.user.uid)
                  .updateProfilePicture(downloadAddress);
            } else {
              await DatabaseService(uid: widget.user.uid)
                  .updateProfilePicture(widget.userData.profilePicture);
            }
          }

          HapticFeedback.heavyImpact();
          FocusScope.of(context).unfocus();
          try {
            if (widget.formKey.currentState.validate()) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wrapper(),
                ),
                (route) => false,
              );
              await DatabaseService(uid: widget.user.uid).updateUserData(
                widget.fullName ?? widget.userData.fullName,
                widget.occupation ?? widget.userData.occupation,
                widget.userData.phoneNumber ?? widget.userData.phoneNumber,
                widget.userData.countryCode ?? widget.userData.countryCode,
                widget.userData.phoneIsoCode ?? widget.userData.phoneIsoCode,
                widget.userData.nonInternationalNumber ??
                    widget.userData.nonInternationalNumber,
              );
              setProfilePicture();
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
