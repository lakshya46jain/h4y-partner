// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/handbook_screen.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/screens/personal_data_screen.dart';
import 'package:h4y_partner/screens/profile_screen/components/profile_stream.dart';

class ProfileScreenBody extends StatefulWidget {
  final Help4YouUser user;

  const ProfileScreenBody({
    @required this.user,
  });

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  Future<void> launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.user != null) ...[
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
            icon: CupertinoIcons.info_circle,
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
            icon: CupertinoIcons.person,
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
            icon: CupertinoIcons.square_arrow_right,
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
            icon: CupertinoIcons.star,
            text: "Rate Us",
            onTap: () {},
          ),
          SignatureButton(
            type: "Expanded",
            icon: CupertinoIcons.chat_bubble_2,
            text: "Feedback",
            onTap: () {
              launchInApp(
                "https://forms.monday.com/forms/ba695d95450030253d57b12f027b44dc?r=use1",
              );
            },
          ),
          SignatureButton(
            type: "Expanded",
            icon: CupertinoIcons.share,
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
