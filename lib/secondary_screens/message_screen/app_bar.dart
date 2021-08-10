// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:h4y_partner/constants/back_button.dart';

class MessageAppBar extends StatelessWidget {
  final String profilePicture;
  final String fullName;
  final String phoneNumber;

  MessageAppBar({
    @required this.profilePicture,
    @required this.fullName,
    @required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white.withOpacity(0.5),
      leading: CustomBackButton(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFF5F6F9),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: profilePicture,
                fit: BoxFit.fill,
              ),
            ),
            radius: 21.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: TextStyle(
                  height: 1.0,
                  fontSize: 20.0,
                  fontFamily: "BalooPaaji",
                  color: Color(0xFF1C3857),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            FluentIcons.call_24_regular,
            size: 27.0,
            color: Color(0xFFFEA700),
          ),
          onPressed: () {
            FlutterPhoneDirectCaller.callNumber(phoneNumber);
          },
        ),
      ],
    );
  }
}
