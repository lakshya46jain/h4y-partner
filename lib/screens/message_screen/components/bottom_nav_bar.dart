// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:awesome_dialog/awesome_dialog.dart';
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
                          Widget dialogButton(
                              String title, Color color, Function onTap) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 7.5,
                              ),
                              child: GestureDetector(
                                onTap: onTap,
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.INFO,
                            body: Column(
                              children: [
                                dialogButton(
                                  "Camera",
                                  Color(0xFFFEA700),
                                  cameraOnPressed,
                                ),
                                dialogButton(
                                  "Photo & Video Library",
                                  Color(0xFF1C3857),
                                  galleryOnPressed,
                                ),
                                SizedBox(height: 7.5),
                              ],
                            ),
                          ).show();
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
                              CupertinoIcons.add,
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
