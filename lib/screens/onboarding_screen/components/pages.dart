// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
// File Imports

class Pages extends StatelessWidget {
  final String graphicImage;
  final String title;
  final String description;
  Pages({
    @required this.graphicImage,
    @required this.title,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.39,
            child: SvgPicture.asset(graphicImage),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            title,
            style: TextStyle(
              height: 1.5,
              fontSize: 26.0,
              color: Colors.white,
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            description,
            style: TextStyle(
              height: 1.3,
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: "BalooPaaji",
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
