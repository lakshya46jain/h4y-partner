// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/primary_screens/wrapper.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/secondary_screens/register_profile_screen/stream_builder.dart';

class RegisterProfileScreen extends StatefulWidget {
  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  // Text Field Variables
  String fullName;
  String occupation;
  String countryCode;
  String phoneIsoCode;
  String nonInternationalNumber;

  // Global Key
  final formKey = GlobalKey<FormState>();

  // Active Image File
  File imageFile;

  // Crop Selected Image
  Future cropImage(XFile selectedFile) async {
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
          imageFile = cropped;
        },
      );
    }
  }

  // Select Image Via Image Picker
  Future getImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    if (selected != null) {
      cropImage(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                    color: Color(0xFF95989A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 50),
                ),
                ProfileStreamBuilder(
                  imageFile: imageFile,
                  occupation: occupation,
                  fullName: fullName,
                  onChanged1: (val) {
                    setState(() {
                      fullName = val;
                    });
                  },
                  onChanged2: (occupationValue) {
                    setState(() {
                      occupation = occupationValue;
                    });
                  },
                  onChanged3: (phone) {
                    setState(() {
                      nonInternationalNumber = phone.number;
                    });
                  },
                  onCountryChanged: (phone) {
                    setState(() {
                      countryCode = phone.countryCode;
                      phoneIsoCode = phone.countryISOCode;
                    });
                  },
                  onPressed1: () => getImage(
                    ImageSource.camera,
                  ),
                  onPressed2: () => getImage(
                    ImageSource.gallery,
                  ),
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
                        withIcon: true,
                        text: "CONTINUE",
                        icon: FluentIcons.arrow_right_24_filled,
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
                                  .updateProfilePicture(
                                userData.profilePicture,
                              );
                            }
                          }

                          HapticFeedback.heavyImpact();
                          FocusScope.of(context).unfocus();
                          try {
                            if (formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                fullName ?? userData.fullName,
                                occupation ?? userData.occupation,
                                "$countryCode$nonInternationalNumber" ??
                                    userData.phoneNumber,
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
        ),
      ),
    );
  }
}
