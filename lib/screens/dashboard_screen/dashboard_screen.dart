// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/screens/dashboard_screen/components/body.dart';
import 'package:h4y_partner/screens/dashboard_screen/components/header.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Header(),
            Expanded(
              child: DashboardScreenBody(),
            ),
          ],
        ),
      ),
    );
  }
}
