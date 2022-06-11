// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/messages_model.dart';
import 'package:h4y_partner/screens/message_screen/message_screen.dart';

class MessageTile extends StatelessWidget {
  final Help4YouUser user;
  final String chatRoomId;
  final String customerUID;

  const MessageTile({
    Key key,
    @required this.user,
    @required this.chatRoomId,
    @required this.customerUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(customerUID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Professional Data Strings
          String profilePicture = snapshot.data["Profile Picture"];
          String fullName = snapshot.data["Full Name"];
          String phoneNumber = snapshot.data["Phone Number"];
          String status = snapshot.data["Status"];

          // Message Tile
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    uid: customerUID,
                    profilePicture: profilePicture,
                    fullName: fullName,
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFF5F6F9),
                        backgroundImage: CachedNetworkImageProvider(
                          profilePicture,
                        ),
                      ),
                      (status == "Online")
                          ? Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00BF6D),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  StreamBuilder(
                    stream: DatabaseService(
                      uid: user.uid,
                      customerUID: customerUID,
                    ).lastMessageData,
                    builder: (context, snapshot) {
                      List<Messages> messages = snapshot.data;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      fullName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF1C3857),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      (snapshot.hasData && messages.isNotEmpty)
                                          ? DateFormat('dd/MM/yy').format(
                                              messages[0]
                                                  .timeStamp
                                                  .toDate()
                                                  .toLocal())
                                          : "",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("H4Y Chat Rooms Database")
                                    .doc(chatRoomId)
                                    .collection("Messages")
                                    .where("Is Read", isEqualTo: false)
                                    .where(
                                      "Sender",
                                      isEqualTo: customerUID,
                                    )
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  int unreadLength = (snapshot.hasData)
                                      ? snapshot.data.docs.length
                                      : 0;
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: (snapshot.hasData &&
                                                  messages.isNotEmpty)
                                              ? Text(
                                                  (messages[0].type ==
                                                              "Media" &&
                                                          messages[0].sender ==
                                                              user.uid)
                                                      ? "You: Sent a photo\n"
                                                      : (messages[0].type ==
                                                                  "Media" &&
                                                              messages[0]
                                                                      .sender !=
                                                                  user.uid)
                                                          ? "Sent a photo\n"
                                                          : (messages[0]
                                                                      .sender ==
                                                                  user.uid)
                                                              ? "You: ${messages[0].message}\n"
                                                              : "${messages[0].message}\n",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                )
                                              : const Text(
                                                  "\n\n",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (unreadLength != 0) ? 10.0 : 0.0,
                                      ),
                                      (unreadLength != 0)
                                          ? ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                minWidth: 20.0,
                                                maxWidth: 50.0,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3.5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF1C3857),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                child: Center(
                                                  widthFactor: 2.0,
                                                  child: Text(
                                                    (unreadLength > 99)
                                                        ? "99+"
                                                        : unreadLength
                                                            .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 5.0),
                              Divider(
                                thickness: 1.5,
                                color: const Color(0xFF95989A).withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
