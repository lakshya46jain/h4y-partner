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
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / (1792 / 725),
            child: Center(
              child: SvgPicture.asset(graphicImage),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  height: 1.5,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 20),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18.0,
                  height: 1.2,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
