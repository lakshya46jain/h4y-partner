// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final String profilePicture;

  MessageBubble({
    @required this.message,
    @required this.isSentByMe,
    @required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (isSentByMe == true)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0,
            ),
            decoration: BoxDecoration(
              color: (isSentByMe == true)
                  ? Color(0xFF1C3857).withOpacity(0.1)
                  : Color(0xFFFEA700).withOpacity(0.2),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
