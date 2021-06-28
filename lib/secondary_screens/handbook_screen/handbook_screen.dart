// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/secondary_screens/handbook_screen/body.dart';
import 'package:h4y_partner/secondary_screens/handbook_screen/app_bar.dart';

class HandbookScreen extends StatefulWidget {
  @override
  _HandbookScreenState createState() => _HandbookScreenState();
}

class _HandbookScreenState extends State<HandbookScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: HandbookAppBar(),
        ),
        body: Body(),
      ),
    );
  }
}
