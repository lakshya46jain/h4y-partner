// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/constants/expanded_button.dart';
import 'package:h4y_partner/screens/about_us_screen/about_us.dart';
import 'package:h4y_partner/screens/settings_screen/stream_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (user != null) ...[
            ProfileCardStreamBuilder(),
            ExpandedButton(
              icon: FluentIcons.info_24_regular,
              text: "About Us",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
            ),
            ExpandedButton(
              icon: FluentIcons.person_feedback_24_regular,
              text: "Feedback",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentIcons.star_24_regular,
              text: "Rate Us",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentIcons.share_24_regular,
              text: "Share Help4You",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentIcons.sign_out_24_regular,
              text: "Sign Out",
              onPressed: () {
                return AuthService().signOut();
              },
            ),
          ] else ...[
            Container(),
          ],
        ],
      ),
    );
  }
}
