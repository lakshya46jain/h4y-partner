// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
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
    return Scaffold(
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
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}