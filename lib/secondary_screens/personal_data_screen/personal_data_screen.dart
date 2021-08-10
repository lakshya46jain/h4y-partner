// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/loading.dart';
import 'package:h4y_partner/constants/expanded_button.dart';
import 'package:h4y_partner/constants/custom_dropdown.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';
import 'package:h4y_partner/constants/phone_number_field.dart';
import 'package:h4y_partner/secondary_screens/delete_account.dart';
import 'package:h4y_partner/secondary_screens/personal_data_screen/app_bar.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  // Text Field Variables
  String fullName;
  String occupation;
  String countryCode;
  String nonInternationalNumber;
  String phoneIsoCode;
  String profilePicture;

  // Global Key
  final formKey = GlobalKey<FormState>();

  // Active Image File
  File imageFile;

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    // Crop Selected Image
    Future _cropImage(XFile selectedFile) async {
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
        _cropImage(selected);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: PersonalDataAppBar(
          formKey: formKey,
          fullName: fullName,
          occupation: occupation,
          phoneNumber: "$countryCode$nonInternationalNumber",
          phoneIsoCode: phoneIsoCode,
          nonInternationalNumber: nonInternationalNumber,
          imageFile: imageFile,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 25),
              ),
              Padding(
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
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                (1792 / 230),
                            width:
                                MediaQuery.of(context).size.width / (828 / 230),
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
                                    height: MediaQuery.of(context).size.height /
                                        (1792 / 92),
                                    width: MediaQuery.of(context).size.width /
                                        (828 / 92),
                                    child: GestureDetector(
                                      onTap: () {
                                        final pickerOptions =
                                            CupertinoActionSheet(
                                          title: Text("Profile Picture"),
                                          message: Text(
                                            "Please select how you want to upload the profile picture",
                                          ),
                                          actions: [
                                            CupertinoActionSheetAction(
                                              onPressed: () => getImage(
                                                ImageSource.camera,
                                              ),
                                              child: Text(
                                                "Camera",
                                              ),
                                            ),
                                            CupertinoActionSheetAction(
                                              onPressed: () => getImage(
                                                ImageSource.gallery,
                                              ),
                                              child: Text(
                                                "Gallery",
                                              ),
                                            ),
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                            ),
                                          ),
                                        );
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              pickerOptions,
                                        );
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
                                          FluentIcons.camera_24_regular,
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
                            height: MediaQuery.of(context).size.height /
                                (1792 / 75),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 10.0,
                            ),
                            child: CustomTextField(
                              keyboardType: TextInputType.name,
                              labelText: "Full Name",
                              hintText: "Full Name",
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                (1792 / 30),
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
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem> occupationItems = [];
                                  for (int i = 0;
                                      i < snapshot.data.docs.length;
                                      i++) {
                                    DocumentSnapshot snap =
                                        snapshot.data.docs[i];
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
                                    labelText: 'Occupation',
                                    hintText: 'Choose occupation',
                                    value: userData.occupation,
                                    validator: (occupationValue) {
                                      if (occupationValue.isEmpty) {
                                        return "Please select an occupation";
                                      } else {
                                        return null;
                                      }
                                    },
                                    icon: FluentIcons
                                        .arrow_circle_down_right_24_regular,
                                    items: occupationItems,
                                    onChanged: (occupationValue) {
                                      setState(() {
                                        occupation = occupationValue;
                                      });
                                    },
                                  );
                                } else {
                                  return CustomDropdown(
                                    labelText: 'Occupation',
                                    hintText: 'Choose occupation',
                                    validator: (occupationValue) {
                                      if (occupationValue.isEmpty) {
                                        return "Please select an occupation";
                                      } else {
                                        return null;
                                      }
                                    },
                                    icon: FluentIcons
                                        .arrow_circle_down_right_24_regular,
                                    items: [
                                      'Appliance Repairs',
                                      'Carpenter',
                                      'Electrician',
                                      'Gardener',
                                      'Painter',
                                      'Pest Control',
                                      'Plumber',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (occupationValue) {
                                      setState(() {
                                        occupation = occupationValue;
                                      });
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                (1792 / 30),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: PhoneNumberTextField(
                              phoneIsoCode: userData.phoneIsoCode,
                              nonInternationalNumber:
                                  userData.nonInternationalNumber,
                              onChanged: (phone) {
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
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                (1792 / 30),
                          ),
                        ],
                      );
                    } else {
                      return DoubleBounceLoading();
                    }
                  },
                ),
              ),
              ExpandedButton(
                icon: FluentIcons.delete_24_regular,
                text: "Delete Account",
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteAccountScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
