// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:flutter_markdown/flutter_markdown.dart';
// File Imports
import 'package:h4y_partner/constants/signature_button.dart';

class PolicyDialog extends StatelessWidget {
  final double radius;
  final String mdFileName;

  PolicyDialog({
    this.radius = 10,
    @required this.mdFileName,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then(
                (value) {
                  return rootBundle.loadString(
                    'assets/files/$mdFileName',
                  );
                },
              ),
              builder: (context, snapshot) {
                return Markdown(
                  data: snapshot.data,
                );
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
