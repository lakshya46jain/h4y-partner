// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class MessageBubble extends StatelessWidget {
  final String chatRoomId;
  final String messageId;
  final String message;
  final String type;
  final bool isSentByMe;
  final String profilePicture;

  MessageBubble({
    @required this.chatRoomId,
    @required this.messageId,
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
        CupertinoContextMenu(
          actions: [
            (type != "Media")
                ? CupertinoContextMenuAction(
                    child: Text("Copy"),
                    trailingIcon: CupertinoIcons.doc_on_doc,
                    onPressed: () async {
                      await FlutterClipboard.copy(message);
                      Navigator.pop(context);
                    },
                  )
                : CupertinoContextMenuAction(
                    child: Text("Save"),
                    trailingIcon: CupertinoIcons.download_circle,
                    onPressed: () async {
                      await ImageDownloader.downloadImage(message);
                      Navigator.pop(context);
                    },
                  ),
            if (isSentByMe == true)
              CupertinoContextMenuAction(
                isDestructiveAction: true,
                child: Text("Delete"),
                trailingIcon: CupertinoIcons.delete,
                onPressed: () async {
                  if (type == "Media") {
                    await FirebaseStorage.instance.refFromURL(message).delete();
                  }
                  await FirebaseFirestore.instance
                      .collection("H4Y Chat Rooms Database")
                      .doc(chatRoomId)
                      .collection("Messages")
                      .doc(messageId)
                      .delete();
                  Navigator.pop(context);
                },
              ),
          ],
          previewBuilder: (context, animation, child) {
            return (type == "Media")
                ? SizedBox.expand(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: message,
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: (isSentByMe == true)
                            ? Color.fromARGB(255, 232, 235, 238)
                            : Color.fromARGB(255, 252, 237, 207),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
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
                  );
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: (type == "Media")
                  ? MediaQuery.of(context).size.height * 0.4
                  : 0.0,
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.all(
                (type == "Media") ? 5.0 : 15.0,
              ),
              decoration: BoxDecoration(
                color: (isSentByMe == true)
                    ? Color(0xFF1C3857).withOpacity(0.1)
                    : Color(0xFFFEA700).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: (type == "Media")
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: message,
                      ),
                    )
                  : Material(
                      color: Colors.transparent,
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
          ),
        ),
      ],
    );
  }
}
