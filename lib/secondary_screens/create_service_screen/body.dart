// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  final Function onChanged4;
  final Function onPressed;
  final bool visibility;

  Body({
    this.formKey,
    this.onChanged1,
    this.onChanged2,
    this.onChanged3,
    this.onChanged4,
    this.onPressed,
    this.visibility,
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
              MergeSemantics(
                child: Container(
                  padding: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Color(0xFF1C3857),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      FluentIcons.eye_show_24_regular,
                      size: 30.0,
                      color: Color(0xFF1C3857),
                    ),
                    title: Text(
                      'Service Visbility',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "BalooPaaji",
                        color: Color(0xFF1C3857),
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: visibility,
                      onChanged: onChanged4,
                      activeColor: Color(0xFF1C3857),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 50),
              ),
              SignatureButton(
                text: "Create Service",
                onTap: onPressed,
                withIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
