// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_spinkit/flutter_spinkit.dart';
// File Imports

class PouringHourGlassPageLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Center(
        child: SpinKitPouringHourglass(
          color: Colors.deepOrangeAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
