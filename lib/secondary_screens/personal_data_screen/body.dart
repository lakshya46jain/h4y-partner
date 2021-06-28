// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/constants/expanded_button.dart';
import 'package:h4y_partner/secondary_screens/personal_data_screen/stream_builder.dart';
import 'package:h4y_partner/secondary_screens/delete_account_screen/delete_account.dart';

class Body extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final File imageFile;
  final String fullName;
  final String occupation;
  final Function onChanged1;
  final Function onChanged2;
  final Function onPhoneNumberChange;
  final Function onPressed1;
  final Function onPressed2;

  Body({
    this.formKey,
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
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 25),
            ),
            EditProfileStreamBuilder(
              imageFile: imageFile,
              fullName: fullName,
              occupation: occupation,
              onChanged1: onChanged1,
              onChanged2: onChanged2,
              onPhoneNumberChange: onPhoneNumberChange,
              onPressed1: onPressed1,
              onPressed2: onPressed2,
            ),
            ExpandedButton(
              icon: FluentIcons.delete_24_regular,
              text: "Delete Account",
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteAccount(),
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
