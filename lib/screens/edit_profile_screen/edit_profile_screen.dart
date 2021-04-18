// Flutter Imports
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
// File Imports
import 'package:h4y_partner/screens/edit_profile_screen/body.dart';
import 'package:h4y_partner/screens/edit_profile_screen/app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Text Field Variables
  String fullName;
  String occupation;
  String phoneNumber;
  String nonInternationalNumber;
  String phoneIsoCode;
  String profilePicture;
  String errorMessage;

  // Global Key
  final _formKey = GlobalKey<FormState>();

  // Active Image File
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    // Crop Selected Image
    Future _cropImage(PickedFile selectedFile) async {
      File cropped = await ImageCropper.cropImage(
        sourcePath: selectedFile.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1.0,
          ratioY: 1.0,
        ),
        cropStyle: CropStyle.circle,
      );
      if (cropped != null) {
        setState(
          () {
            _imageFile = cropped;
          },
        );
      }
    }

    // Select Image Via Image Picker
    Future getImage(ImageSource source) async {
      final selected = await ImagePicker().getImage(source: source);
      if (selected != null) {
        _cropImage(selected);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: EditProfileBar(
            formKey: _formKey,
            fullName: fullName,
            occupation: occupation,
            phoneNumber: phoneNumber,
            phoneIsoCode: phoneIsoCode,
            nonInternationalNumber: nonInternationalNumber,
            imageFile: _imageFile,
          ),
        ),
        body: Body(
          fullName: fullName,
          occupation: occupation,
          imageFile: _imageFile,
          formKey: _formKey,
          onChanged1: (val) {
            setState(() => fullName = val);
          },
          onChanged2: (occupationValue) {
            setState(
              () {
                occupation = occupationValue;
              },
            );
          },
          onPhoneNumberChange: (
            String number,
            String internationalizedPhoneNumber,
            String isoCode,
          ) {
            setState(
              () {
                phoneNumber = internationalizedPhoneNumber;
                phoneIsoCode = isoCode;
                nonInternationalNumber = number;
              },
            );
          },
          onPressed1: () => getImage(
            ImageSource.camera,
          ),
          onPressed2: () => getImage(
            ImageSource.gallery,
          ),
        ),
      ),
    );
  }
}