// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class MessageBubble extends StatelessWidget {
  final String message;
  final String type;
  final bool isSentByMe;
  final String profilePicture;

  MessageBubble({
    @required this.message,
    @required this.type,
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
            minHeight: (type == "Media")
                ? MediaQuery.of(context).size.height * 0.4
                : 0.0,
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.all(
              (type == "Media") ? 10.0 : 15.0,
            ),
            decoration: BoxDecoration(
              color: (isSentByMe == true)
                  ? Color(0xFF1C3857).withOpacity(0.1)
                  : Color(0xFFFEA700).withOpacity(0.2),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: (type == "Media")
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: message,
                    ),
                  )
                : Text(
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
