// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/bottom_nav_bar.dart';
import 'package:h4y_partner/screens/server_error_screen.dart';
import 'package:h4y_partner/screens/onboarding_screen/onboarding_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // Check Internet Connectivity
  bool hasConnection;
  checkInternetConnectivity() async {
    hasConnection = await InternetConnectionChecker().hasConnection;
    setState(() {});
  }

  @override
  void initState() {
    checkInternetConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    // Firebase Crashlytics User Identifier
    if (user != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(user.uid);
    } else {
      FirebaseCrashlytics.instance.setUserIdentifier("Anonyomous User");
    }

    return PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: (hasConnection == false)
          ? ServerErrorScreen(
              onPressed: () => checkInternetConnectivity(),
            )
          : (user != null)
              ? BottomNavBar()
              : OnboardingScreen(),
    );
  }
}
