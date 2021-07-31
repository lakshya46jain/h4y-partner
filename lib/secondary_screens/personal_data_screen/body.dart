// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/constants/expanded_button.dart';
import 'package:h4y_partner/secondary_screens/delete_account.dart';
import 'package:h4y_partner/secondary_screens/personal_data_screen/stream_builder.dart';

class Body extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final File imageFile;
  final String fullName;
  final String occupation;
  final Function onChanged1;
  final Function onChanged2;
  final Function onChanged3;
  final Function onPressed1;
  final Function onPressed2;
  final Function onCountryChanged;

  Body({
    @required this.formKey,
    @required this.imageFile,
    @required this.fullName,
    @required this.occupation,
    @required this.onChanged1,
    @required this.onChanged2,
    @required this.onChanged3,
    @required this.onPressed1,
    @required this.onPressed2,
    @required this.onCountryChanged,
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
              onChanged3: onChanged3,
              onPressed1: onPressed1,
              onPressed2: onPressed2,
              onCountryChanged: onCountryChanged,
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
    );
  }
}
