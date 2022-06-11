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

  const EditServiceScreen({
    Key key,
    @required this.documentId,
  }) : super(key: key);

  @override
  EditServiceScreenState createState() => EditServiceScreenState();
}

class EditServiceScreenState extends State<EditServiceScreen> {
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
          leading: const SignatureButton(type: "Back Button"),
          title: const Text(
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
                        const SizedBox(height: 25.0),
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
                        const SizedBox(height: 25.0),
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
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                              title: const Text(
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
                                activeColor: const Color(0xFF1C3857),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        SignatureButton(
                          text: "Update Service",
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState.validate()) {
                              await DatabaseService(
                                documentId: widget.documentId,
                                uid: user.uid,
                              )
                                  .updateProfessionalServices(
                                    serviceTitle ?? services.serviceTitle,
                                    serviceDescription ??
                                        services.serviceDescription,
                                    servicePrice ?? services.servicePrice,
                                    visibility ?? services.visibility,
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
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
