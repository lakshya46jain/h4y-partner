// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
// File Imports
import 'package:h4y_partner/constants/custom_text_field.dart';
import 'package:h4y_partner/screens/onboarding_screen/components/phone_auth_screen.dart';
import 'package:h4y_partner/screens/onboarding_screen/components/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  // Initial Page Value
  int _currentPage = 0;

  // Phone Number Field Variables
  String countryCode = "+1";
  String phoneIsoCode = "US";
  String nonInternationalNumber;
  FocusNode focusNode = FocusNode();

  // Page Controller
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Navigator.push(
          context,
          PageTransition(
            child: PhoneAuthScreen(
              countryCode: countryCode,
              phoneIsoCode: phoneIsoCode,
              nonInternationalNumber: nonInternationalNumber,
            ),
            type: PageTransitionType.bottomToTop,
          ),
        );
      }
    });
    super.initState();
  }

  // Indicator Container
  Widget _indicator(bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        height: isActive ? 12.0 : 8.0,
        width: isActive ? 12.0 : 8.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
    );
  }

  // Build Page Indicator
  List _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
        i == _currentPage ? _indicator(true) : _indicator(false),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1C3857),
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 225,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100.0),
                OnboardingPageView(
                  pageController: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    bottom: 40.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildPageIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 225.0,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's get started! Enter your mobile number.",
                  style: GoogleFonts.balooPaaji2(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    CustomFields(
                      type: "Phone",
                      focusNode: focusNode,
                      phoneIsoCode: phoneIsoCode,
                      nonInternationalNumber: nonInternationalNumber,
                      onChanged: (phone) {},
                      onCountryChanged: (phone) {
                        setState(() {
                          countryCode = phone.dialCode;
                          phoneIsoCode = phone.code;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
