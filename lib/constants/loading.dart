// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_spinkit/flutter_spinkit.dart';
// File Imports

class DoubleBounceLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Center(
        child: SpinKitDoubleBounce(
          color: Color(0xFF1C3857),
          size: 50.0,
        ),
      ),
    );
  }
}
