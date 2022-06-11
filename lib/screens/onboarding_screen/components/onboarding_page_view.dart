// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/screens/onboarding_screen/components/pages.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController pageController;
  final Function onPageChanged;

  const OnboardingPageView({
    Key key,
    @required this.pageController,
    @required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          // Page 1
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_1.svg",
            title: "Connect With People",
            description:
                "Connect with people in your locality by accpeting bookings and earn.",
          ),
          // Page 2
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_3.svg",
            title: "New Experiences",
            description:
                "Set your own prices and get those know to people around you.",
          ),
          // Page 3
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_4.svg",
            title: "Important Note",
            description:
                "By registering, you will not be associated with Help4You.",
          ),
        ],
      ),
    );
  }
}
