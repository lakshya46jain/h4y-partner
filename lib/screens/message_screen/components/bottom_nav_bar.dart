// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class MessageNavBar extends StatelessWidget {
  final bool isMessageEmpty;
  final Function onChanged;
  final Function cameraOnPressed;
  final Function galleryOnPressed;
  final Function onPressed;
  final TextEditingController messageController;

  MessageNavBar({
    @required this.isMessageEmpty,
    @required this.onChanged,
    @required this.cameraOnPressed,
    @required this.galleryOnPressed,
    @required this.onPressed,
    @required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10.0,
        bottom: 10.0,
      ),
      color: Colors.white,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF95989A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Color(0xFF95989A).withOpacity(0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: "Message...",
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF95989A),
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xFF95989A).withOpacity(0.01),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(0xFF95989A).withOpacity(0.01),
                      ),
                    ),
                  ),
                  onChanged: onChanged,
                  controller: messageController,
                ),
              ),
              (isMessageEmpty == true)
                  ? Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          final pickerOptions = CupertinoActionSheet(
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: cameraOnPressed,
                                child: Row(
                                  children: [
                                    Icon(
                                      FluentIcons.camera_20_regular,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      "Camera",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: galleryOnPressed,
                                child: Row(
                                  children: [
                                    Icon(
                                      FluentIcons.image_20_regular,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      "Photo & Video Library",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) => pickerOptions,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1C3857),
                            shape: BoxShape.circle,
                          ),
                          height: 40.0,
                          width: 40.0,
                          child: Center(
                            child: Icon(
                              FluentIcons.add_12_filled,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: onPressed,
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF1C3857),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
