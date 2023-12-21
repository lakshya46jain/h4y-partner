// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:awesome_dialog/awesome_dialog.dart';
// File Imports

class MessageNavBar extends StatelessWidget {
  final bool? isMessageEmpty;
  final Function(String)? onChanged;
  final VoidCallback? cameraOnPressed;
  final VoidCallback? galleryOnPressed;
  final VoidCallback? onPressed;
  final TextEditingController? messageController;
  final String? messageType;
  final bool? isLongPress;
  final VoidCallback? unsendOnTap;
  final VoidCallback? copySaveOnTap;
  final bool? isSentByMe;

  final TextStyle textStyle = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  const MessageNavBar({
    Key? key,
    required this.isMessageEmpty,
    required this.onChanged,
    required this.cameraOnPressed,
    required this.galleryOnPressed,
    required this.onPressed,
    required this.messageController,
    required this.messageType,
    required this.isLongPress,
    required this.unsendOnTap,
    required this.copySaveOnTap,
    required this.isSentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: (isLongPress == true)
              ? const BorderSide(width: 0.5, color: Colors.grey)
              : BorderSide.none,
        ),
      ),
      padding: EdgeInsets.only(
        top: (isLongPress == true) ? 8.5 : 0.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: SafeArea(
        child: (isLongPress == true)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (isSentByMe == true)
                      GestureDetector(
                        onTap: unsendOnTap,
                        // ignore: prefer_const_constructors
                        child: Text(
                          "Unsend",
                          style: textStyle,
                        ),
                      ),
                    GestureDetector(
                      onTap: copySaveOnTap,
                      child: Text(
                        (messageType != "Media") ? "Copy" : "Save",
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF95989A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: const Color(0xFF95989A).withOpacity(0),
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
                          hintStyle: const TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF95989A),
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: const Color(0xFF95989A).withOpacity(0.01),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: const Color(0xFF95989A).withOpacity(0.01),
                            ),
                          ),
                        ),
                        onChanged: onChanged,
                        controller: messageController,
                      ),
                    ),
                    (isMessageEmpty == true)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                Widget dialogButton(String title, Color color,
                                    VoidCallback onTap) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 7.5,
                                    ),
                                    child: GestureDetector(
                                      onTap: onTap,
                                      child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            title,
                                            style: const TextStyle(
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
                                  dialogType: DialogType.info,
                                  body: Column(
                                    children: [
                                      dialogButton(
                                        "Camera",
                                        const Color(0xFFFEA700),
                                        cameraOnPressed!,
                                      ),
                                      dialogButton(
                                        "Photo & Video Library",
                                        const Color(0xFF1C3857),
                                        galleryOnPressed!,
                                      ),
                                      const SizedBox(height: 7.5),
                                    ],
                                  ),
                                ).show();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1C3857),
                                  shape: BoxShape.circle,
                                ),
                                height: 40.0,
                                width: 40.0,
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: onPressed,
                              child: const Text(
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
