// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/bottom_nav_bar.dart';
import 'package:h4y_partner/screens/onboarding_screen/onboarding_screen.dart';

class Wrapper extends StatelessWidget {
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
      child: user != null ? BottomNavBar() : OnboardingScreen(),
    );
  }
}
