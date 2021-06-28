// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/primary_screens/welcome_screen/pages.dart';

class PageViewContainer extends StatelessWidget {
  final PageController pageController;
  final Function onPageChanged;

  PageViewContainer({
    @required this.pageController,
    @required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / (1792 / 1400),
      child: PageView(
        physics: ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          // Page 1
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_1.svg",
            title: "Connect with people in your local area",
            description:
                "H4Y Partner allows you to accept bookings made by the customers using the Help4You App. This allows you to get jobs and earn.",
          ),
          // Page 2
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_3.svg",
            title: "Get a new experience of getting tasks done",
            description:
                "H4Y Partner allows you to set your own prices and get it known by various people in your area.",
          ),
          // Page 3
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_4.svg",
            title: "Note",
            description:
                "By creating an account in H4Y Partner does not associate you with Help4You. Help4You is a platform which will allow you to get notified about the work & you can reach to your customers.",
          ),
        ],
      ),
    );
  }
}
