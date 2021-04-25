// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/screens/add_service_screen/body.dart';
import 'package:h4y_partner/screens/add_service_screen/app_bar.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  // Text Field Variable
  String serviceTitle;
  String serviceDescription;
  int servicePrice;

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
          child: AddServiceAppBar(),
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
        ),
        body: Body(
          onChanged1: (value) {
            setState(
              () {
                serviceTitle = value;
              },
            );
          },
          onChanged2: (value) {
            setState(
              () {
                serviceDescription = value;
              },
            );
          },
          onChanged3: (value) {
            setState(
              () {
                servicePrice = value;
              },
            );
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
