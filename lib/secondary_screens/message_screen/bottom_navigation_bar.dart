// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class MessageNavBar extends StatelessWidget {
  final bool isMessageEmpty;
  final Function onChanged;
  final Function onPressed;
  final TextEditingController messageController;

  MessageNavBar({
    @required this.isMessageEmpty,
    @required this.onChanged,
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
                        onTap: () {},
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
