// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/constants/policy_dialog.dart';
import 'package:h4y_partner/constants/signature_button.dart';

class HandbookScreen extends StatefulWidget {
  @override
  _HandbookScreenState createState() => _HandbookScreenState();
}

class _HandbookScreenState extends State<HandbookScreen> {
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
          leading: SignatureButton(type: "Back Button"),
          title: Text(
            "Our Handbook",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                      return PolicyDialog(
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
                      return PolicyDialog(
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
                      return PolicyDialog(
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
