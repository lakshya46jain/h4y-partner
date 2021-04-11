// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/bottom_nav_bar.dart';
import 'package:h4y_partner/screens/welcome_screen/welcome_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Container(
      color: Colors.white,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (
          widget,
          animation,
        ) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1.0, 0.0),
            end: Offset(0.0, 0.0),
          ).animate(
            animation,
          ),
          child: widget,
        ),
        child: (user == null) ? WelcomeScreen() : BottomNavBar(),
      ),
    );
  }
}
