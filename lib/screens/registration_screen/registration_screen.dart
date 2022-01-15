// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/custom_dropdown.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';
import 'package:h4y_partner/screens/registration_screen/components/registration_continue_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Text Field Variables
  String fullName;
  String occupation;

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Register Details",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: StreamBuilder(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              UserDataProfessional userData = snapshot.data;
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 115.0,
                        width: 115.0,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: (imageFile != null)
                                    ? Image.file(
                                        imageFile,
                                        fit: BoxFit.fill,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: userData.profilePicture,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: -15,
                              bottom: -10,
                              child: SizedBox(
                                height: 46.0,
                                width: 46.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Widget dialogButton(String title,
                                        Color color, Function onTap) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical: 7.5,
                                        ),
                                        child: GestureDetector(
                                          onTap: onTap,
                                          child: Container(
                                            padding: EdgeInsets.all(15.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: color,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    AwesomeDialog(
                                      context: context,
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.INFO,
                                      body: Column(
                                        children: [
                                          dialogButton(
                                            "Camera",
                                            Color(0xFFFEA700),
                                            () => getImage(ImageSource.camera),
                                          ),
                                          dialogButton(
                                            "Photo Library",
                                            Color(0xFF1C3857),
                                            () => getImage(ImageSource.gallery),
                                          ),
                                          SizedBox(height: 7.5),
                                        ],
                                      ),
                                    ).show();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color(0xFFF2F3F7),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 15),
                                            blurRadius: 20.0,
                                            color: Color(0xFFDADADA),
                                          ),
                                        ]),
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      color: Color(0xFF1C3857),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomFields(
                          type: "Normal",
                          keyboardType: TextInputType.name,
                          hintText: "Enter Full Name...",
                          initialValue: userData.fullName,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Name field cannot be empty";
                            } else if (value.length < 2) {
                              return "Name must be atleast 2 characters long";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              fullName = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("H4Y Occupation Database")
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<DropdownMenuItem> occupationItems = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              occupationItems.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap['Occupation'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: snap['Occupation'],
                                ),
                              );
                            }
                            return CustomDropdown(
                              hintText: 'Select Occupation...',
                              value: userData.occupation,
                              validator: (occupationValue) {
                                if (occupationValue.isEmpty) {
                                  return "Occupation field cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              icon: CupertinoIcons.arrow_down_right_circle,
                              items: occupationItems,
                              onChanged: (occupationValue) {
                                setState(() {
                                  occupation = occupationValue;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      RegistrationContinueButton(
                        imageFile: imageFile,
                        user: user,
                        userData: userData,
                        formKey: formKey,
                        fullName: fullName,
                        occupation: occupation,
                      ),
                    ],
                  ),
                );
              } else {
                return Container(width: 0.0, height: 0.0);
              }
            },
          ),
        ),
      ),
    );
  }
}
