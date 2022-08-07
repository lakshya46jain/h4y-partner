// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// File Imports

class Pages extends StatelessWidget {
  final String graphicImage;
  final String title;
  final String description;

  const Pages({
    Key key,
    @required this.graphicImage,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: SvgPicture.asset(graphicImage),
          ),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: GoogleFonts.balooPaaji2(
              height: 1.5,
              fontSize: 26.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            style: GoogleFonts.balooPaaji2(
              height: 1.3,
              fontSize: 20.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
