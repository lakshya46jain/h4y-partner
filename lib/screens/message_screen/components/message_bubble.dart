// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
// File Imports

class MessageBubble extends StatelessWidget {
  final String chatRoomId;
  final String messageId;
  final String message;
  final String type;
  final bool isSentByMe;
  final String profilePicture;
  final bool isRead;
  final Function onLongPress;

  const MessageBubble({
    Key key,
    @required this.chatRoomId,
    @required this.messageId,
    @required this.message,
    @required this.type,
    @required this.isSentByMe,
    @required this.profilePicture,
    @required this.isRead,
    @required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (isSentByMe == true)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onLongPress: onLongPress,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Container(
                      padding: EdgeInsets.all((type == "Media") ? 5.0 : 15.0),
                      decoration: BoxDecoration(
                        color: (isSentByMe == true)
                            ? const Color(0xFF5DD3B0).withOpacity(0.12)
                            : const Color(0xFFA6A6A6).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: (type == "Media")
                          ? FullScreenWidget(
                              disposeLevel: DisposeLevel.High,
                              child: Center(
                                child: Hero(
                                  tag: "Message Media",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: message,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              message,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
                (isSentByMe == true)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          (isRead == true)
                              ? CupertinoIcons.checkmark_alt_circle_fill
                              : CupertinoIcons.checkmark_alt_circle,
                          size: 18.0,
                          color: const Color(0xFF00BF6D),
                        ),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ],
    );
  }
}
