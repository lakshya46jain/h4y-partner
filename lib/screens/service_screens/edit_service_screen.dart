// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/service_model.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/constants/custom_text_field.dart';

class EditServiceScreen extends StatefulWidget {
  final String documentId;

  EditServiceScreen({
    @required this.documentId,
  });

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
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
          leading: SignatureButton(type: "Back Button"),
          title: Text(
            "Edit Service",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: DatabaseService(documentId: widget.documentId).serviceData,
          builder: (context, snapshot) {
            Help4YouServices services = snapshot.data;
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        CustomFields(
                          type: "Normal",
                          initialValue: services.serviceTitle,
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
                          hintText: "Type Service Title...",
                        ),
                        SizedBox(height: 25.0),
                        CustomFields(
                          type: "Normal",
                          initialValue: services.serviceDescription,
                          onChanged: (value) {
                            setState(() {
                              serviceDescription = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Description field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          hintText: "Type Description Of Service...",
                          maxLines: null,
                        ),
                        SizedBox(height: 25.0),
                        CustomFields(
                          type: "Normal",
                          initialValue: "${services.servicePrice}",
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
                          hintText: "Type Service Price...",
                        ),
                        SizedBox(height: 25.0),
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
                                CupertinoIcons.eye,
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
                                value: services.visibility,
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
                        SizedBox(height: 25.0),
                        SignatureButton(
                          text: "Update Service",
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState.validate()) {
                              await DatabaseService(
                                documentId: widget.documentId,
                                uid: user.uid,
                              ).updateProfessionalServices(
                                serviceTitle ?? services.serviceTitle,
                                serviceDescription ??
                                    services.serviceDescription,
                                servicePrice ?? services.servicePrice,
                                visibility ?? services.visibility,
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
              );
            } else {
              return Container(width: 0.0, height: 0.0);
            }
          },
        ),
      ),
    );
  }
}
