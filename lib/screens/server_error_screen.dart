// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/svg.dart';
// File Imports

class ServerErrorScreen extends StatelessWidget {
  final VoidCallback? onPressed;

  const ServerErrorScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 2,
            child:
                SvgPicture.asset("assets/graphics/Help4You_Illustration_8.svg"),
          ),
          const SizedBox(height: 30.0),
          const Text(
            "Oops! Something went wrong",
            style: TextStyle(
              fontSize: 21.0,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5.0),
          const Text(
            "The server encountered a temporary error",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            minWidth: 125.0,
            onPressed: onPressed,
            color: const Color(0xFF1C3857),
            child: const Text(
              "Try Again",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
