// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/screens/services_screen/body.dart';
import 'package:h4y_partner/screens/services_screen/app_bar.dart';
import 'package:h4y_partner/screens/add_service_screen/add_service.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: ServicesAppBar(),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FluentIcons.add_28_filled,
          color: Colors.white,
          size: 28.0,
        ),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddServiceScreen(),
            ),
          );
        },
      ),
    );
  }
}
