// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/secondary_screens/create_service_screen/body.dart';
import 'package:h4y_partner/secondary_screens/create_service_screen/app_bar.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          child: CreateServiceAppBar(),
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
        ),
        body: Body(
          onChanged1: (value) {
            setState(() {
              serviceTitle = value;
            });
          },
          onChanged2: (value) {
            setState(() {
              serviceDescription = value;
            });
          },
          onChanged3: (value) {
            setState(() {
              servicePrice = double.parse(value);
            });
          },
          visibility: visibility,
          onChanged4: (bool visbilityStatus) {
            setState(() {
              visibility = visbilityStatus;
            });
          },
          formKey: _formKey,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState.validate()) {
              await DatabaseService(uid: user.uid).updateProfessionalServices(
                serviceTitle,
                serviceDescription,
                servicePrice,
                visibility,
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
