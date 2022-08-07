// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:h4y_partner/constants/policy_dialog.dart';
import 'package:h4y_partner/constants/signature_button.dart';

class HandbookScreen extends StatefulWidget {
  const HandbookScreen({Key key}) : super(key: key);

  @override
  HandbookScreenState createState() => HandbookScreenState();
}

class HandbookScreenState extends State<HandbookScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: const SignatureButton(type: "Back Button"),
          title: Text(
            "Our Handbook",
            style: GoogleFonts.balooPaaji2(
              fontSize: 25.0,
              color: const Color(0xFF1C3857),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SignatureButton(
                type: "Expanded",
                text: "About Help4You",
                icon: CupertinoIcons.question_circle,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const PolicyDialog(
                        mdFileName: 'about_help4you.md',
                      );
                    },
                  );
                },
              ),
              SignatureButton(
                type: "Expanded",
                text: "Terms and Conditions",
                icon: CupertinoIcons.folder_badge_person_crop,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const PolicyDialog(
                        mdFileName: 'terms_and_conditions.md',
                      );
                    },
                  );
                },
              ),
              SignatureButton(
                type: "Expanded",
                text: "Privacy Policy",
                icon: CupertinoIcons.lock_shield,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
