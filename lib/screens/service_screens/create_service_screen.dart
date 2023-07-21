// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({Key? key}) : super(key: key);

  @override
  CreateServiceScreenState createState() => CreateServiceScreenState();
}

class CreateServiceScreenState extends State<CreateServiceScreen> {
  // Text Field Variable
  String? serviceTitle;
  String? serviceDescription;
  double? servicePrice;

  // Visibility Bool
  bool visibility = true;

  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: const SignatureButton(type: "Back Button"),
          title: Text(
            "Create Service",
            style: GoogleFonts.balooPaaji2(
              fontSize: 25.0,
              color: const Color(0xFF1C3857),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  CustomFields(
                    type: "Normal",
                    onChanged: (value) {
                      setState(() {
                        serviceTitle = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Title field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    hintText: "Type Service Title...",
                  ),
                  const SizedBox(height: 25.0),
                  CustomFields(
                    type: "Normal",
                    onChanged: (value) {
                      setState(() {
                        serviceDescription = value;
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    hintText: "Type Description Of Service...",
                    maxLines: null,
                  ),
                  const SizedBox(height: 25.0),
                  CustomFields(
                    type: "Normal",
                    onChanged: (String? value) {
                      setState(() {
                        servicePrice = double.parse(value!);
                      });
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Price field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    hintText: "Type Service Price...",
                  ),
                  const SizedBox(height: 25.0),
                  MergeSemantics(
                    child: Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: const Color(0xFF1C3857),
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          CupertinoIcons.eye,
                          size: 30.0,
                          color: Color(0xFF1C3857),
                        ),
                        title: Text(
                          'Service Visbility',
                          style: GoogleFonts.balooPaaji2(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1C3857),
                          ),
                        ),
                        trailing: CupertinoSwitch(
                          value: visibility,
                          onChanged: (bool visbilityStatus) {
                            setState(() {
                              visibility = visbilityStatus;
                            });
                          },
                          activeColor: const Color(0xFF1C3857),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  SignatureButton(
                    text: "Create Service",
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        await DatabaseService(uid: user!.uid)
                            .createProfessionalServices(
                              serviceTitle,
                              serviceDescription,
                              servicePrice,
                              visibility,
                            )
                            .then(
                              (value) => Navigator.pop(context),
                            );
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
