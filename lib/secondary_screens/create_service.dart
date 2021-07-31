// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/back_button.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';
import 'package:h4y_partner/constants/signature_button.dart';

class CreateServiceScreen extends StatefulWidget {
  @override
  _CreateServiceScreenState createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  // Text Field Variable
  String serviceTitle;
  String serviceDescription;
  double servicePrice;

  // Visibility Bool
  bool visibility = true;

  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: CustomBackButton(),
          title: Text(
            "Create Service",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
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
                    onChanged: (value) {
                      setState(() {
                        serviceTitle = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        serviceDescription = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        servicePrice = double.parse(value);
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Price field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
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
                          onChanged: (bool visbilityStatus) {
                            setState(() {
                              visibility = visbilityStatus;
                            });
                          },
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
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid)
                            .updateProfessionalServices(
                          serviceTitle,
                          serviceDescription,
                          servicePrice,
                          visibility,
                        );
                        Navigator.pop(context);
                      }
                    },
                    withIcon: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
