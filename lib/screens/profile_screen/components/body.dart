// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:share/share.dart';
import 'package:wiredash/wiredash.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/handbook_screen.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/screens/personal_data_screen.dart';
import 'package:h4y_partner/screens/profile_screen/components/profile_stream.dart';

class ProfileScreenBody extends StatelessWidget {
  final Help4YouUser user;

  const ProfileScreenBody({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (user != null) ...[
          SizedBox(
            height: 70.0,
          ),
          ProfileStream(),
          Padding(
            padding: EdgeInsets.only(
                right: 20.0, bottom: 5.0, top: 15.0, left: 20.0),
            child: Divider(
              thickness: 1.0,
              color: Color(0xFF95989A),
            ),
          ),
          SignatureButton(
            type: "Expanded",
            icon: FluentIcons.info_24_regular,
            text: "Our Handbook",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HandbookScreen(),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Divider(
              thickness: 1.0,
              color: Color(0xFF95989A),
            ),
          ),
          SignatureButton(
            type: "Expanded",
            icon: FluentIcons.person_24_regular,
            text: "Personal Data",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalDataScreen(),
                ),
              );
            },
          ),
          SignatureButton(
            type: "Expanded",
            icon: FluentIcons.sign_out_24_regular,
            text: "Sign Out",
            onTap: () {
              return AuthService().signOut();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Divider(
              thickness: 1.0,
              color: Color(0xFF95989A),
            ),
          ),
          SignatureButton(
            type: "Expanded",
            icon: FluentIcons.star_24_regular,
            text: "Rate Us",
            onTap: () {},
          ),
          SignatureButton(
            type: "Expanded",
            icon: FluentIcons.person_feedback_24_regular,
            text: "Feedback",
            onTap: () {
              Wiredash.of(context).setUserProperties(
                userId: user.uid,
              );
              Wiredash.of(context).setBuildProperties(
                buildNumber: "Help4You Partner",
                buildVersion: "",
              );
              Wiredash.of(context).show();
            },
          ),
          SignatureButton(
            type: "Expanded",
            icon: FluentIcons.share_24_regular,
            text: "Share Help4You",
            onTap: () {
              Share.share(
                "Have you tried the Help4You app? It's simple to book services like appliance repair, electricians, gardeners & more...\nTo download our app please visit https://www.help4you.webflow.io/download",
                subject: "Try Help4You",
              );
            },
          ),
        ] else ...[
          Container(),
        ],
      ],
    );
  }
}