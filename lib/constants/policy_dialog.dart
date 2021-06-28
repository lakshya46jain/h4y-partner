// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:flutter_markdown/flutter_markdown.dart';
// File Imports

class PolicyDialog extends StatelessWidget {
  PolicyDialog({
    Key key,
    this.radius = 10,
    @required this.mdFileName,
  })  : assert(
          mdFileName.contains('.md'),
          'The file must contain the .md extension',
        ),
        super(key: key);

  final double radius;
  final String mdFileName;

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
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF1C3857),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / (1792 / 120),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "CLOSE",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
