// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/constants/loading.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/constants/custom_dropdown.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';
import 'package:h4y_partner/constants/phone_number_field.dart';

class EditProfileStreamBuilder extends StatelessWidget {
  final File imageFile;
  final String fullName;
  final String occupation;
  final Function onChanged1;
  final Function onChanged2;
  final Function onPhoneNumberChange;
  final Function onPressed1;
  final Function onPressed2;

  EditProfileStreamBuilder({
    this.imageFile,
    this.fullName,
    this.occupation,
    this.onChanged1,
    this.onChanged2,
    this.onPhoneNumberChange,
    this.onPressed1,
    this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserDataProfessional userData = snapshot.data;
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 230),
                  width: MediaQuery.of(context).size.width / (828 / 230),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 15),
                              blurRadius: 20.0,
                              color: Color(0xFFDADADA),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: SizedBox(
                            child: ClipOval(
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
                        ),
                      ),
                      Positioned(
                        right: -12,
                        bottom: 0,
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height / (1792 / 92),
                          width: MediaQuery.of(context).size.width / (828 / 92),
                          child: GestureDetector(
                            onTap: () {
                              final pickerOptions = CupertinoActionSheet(
                                title: Text("Profile Picture"),
                                message: Text(
                                  "Please select how you want to upload the profile picture",
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: onPressed1,
                                    child: Text(
                                      "Camera",
                                    ),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: onPressed2,
                                    child: Text(
                                      "Gallery",
                                    ),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
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
                                shape: BoxShape.circle,
                                color: Color(0xFFF5F6F9),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Icon(
                                FluentIcons.camera_24_regular,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 75),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: CustomTextField(
                    keyboardType: TextInputType.name,
                    labelText: "Full Name",
                    hintText: "Enter full name",
                    initialValue: userData.fullName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name field cannot be empty";
                      } else if (value.length < 2) {
                        return "Name must be atleast 2 characters long";
                      } else if (value.length > 50) {
                        return "Name must be less than 50 characters long";
                      } else {
                        return null;
                      }
                    },
                    onChanged: onChanged1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Occupation")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return CustomDropdown(
                          labelText: 'Occupation',
                          hintText: 'Choose occupation',
                          icon: FluentIcons.arrow_circle_down_right_24_regular,
                          items: [],
                          onChanged: onChanged2,
                        );
                      else {
                        List<DropdownMenuItem> occupationItems = [];
                        for (int i = 0; i < snapshot.data.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data.docs[i];
                          occupationItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.id,
                                style: TextStyle(color: Colors.black),
                              ),
                              value: "${snap.id}",
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
                          icon: FluentIcons.arrow_circle_down_right_24_regular,
                          items: occupationItems,
                          onChanged: onChanged2,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: PhoneNumberTextField(
                    phoneIsoCode: userData.phoneIsoCode,
                    nonInternationalNumber: userData.nonInternationalNumber,
                    onPhoneNumberChange: onPhoneNumberChange,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 30),
                ),
              ],
            );
          } else {
            return PouringHourGlassPageLoad();
          }
        },
      ),
    );
  }
}
