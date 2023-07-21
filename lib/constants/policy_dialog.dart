// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:flutter_markdown/flutter_markdown.dart';
// File Imports
import 'package:h4y_partner/constants/signature_button.dart';

class PolicyDialog extends StatelessWidget {
  final String mdFileName;

  const PolicyDialog({
    Key? key,
    required this.mdFileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: rootBundle.loadString('assets/files/$mdFileName'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data.toString());
                } else {
                  return Container();
                }
              },
            ),
          ),
          SignatureButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "CLOSE",
            withIcon: false,
          ),
        ],
      ),
    );
  }
}
