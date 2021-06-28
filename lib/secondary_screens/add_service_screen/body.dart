// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';

class Body extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function onChanged1;
  final Function onChanged2;
  final Function onChanged3;
  final Function onPressed;

  Body({
    this.formKey,
    this.onChanged1,
    this.onChanged2,
    this.onChanged3,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 25),
              ),
              CustomTextField(
                onChanged: onChanged1,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Title field cannot be empty";
                  } else {
                    return null;
                  }
                },
                labelText: "Service Title",
                hintText: "Type service title...",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 50),
              ),
              CustomTextField(
                onChanged: onChanged2,
                keyboardType: TextInputType.multiline,
                labelText: "Service Description",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Description field cannot be empty";
                  } else {
                    return null;
                  }
                },
                hintText: "Type short description of service...",
                maxLines: 3,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 50),
              ),
              CustomTextField(
                onChanged: onChanged3,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Price field cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                labelText: "Service Price",
                hintText: "Type service price...",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 50),
              ),
              SignatureButton(
                text: "Add Service",
                icon: FluentIcons.add_24_filled,
                onTap: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
