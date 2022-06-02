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

  MessageTile({
    @required this.user,
    @required this.chatRoomId,
    @required this.customerUID,
  });

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
              padding: EdgeInsets.symmetric(
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
                        backgroundColor: Color(0xFFF5F6F9),
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
                                  color: Color(0xFF00BF6D),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 0.0,
                              width: 0.0,
                            ),
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
                          padding: EdgeInsets.only(left: 15.0),
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
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF1C3857),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      (snapshot.hasData && messages.length != 0)
                                          ? "${DateFormat('dd/MM/yy').format(messages[0].timeStamp.toDate().toLocal())}"
                                          : "",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Opacity(
                                opacity: 0.5,
                                child: (snapshot.hasData &&
                                        messages.length != 0)
                                    ? Text(
                                        (messages[0].type == "Media" &&
                                                messages[0].sender == user.uid)
                                            ? "You: Sent a photo\n"
                                            : (messages[0].type == "Media" &&
                                                    messages[0].sender !=
                                                        user.uid)
                                                ? "Sent a photo\n"
                                                : (messages[0].sender ==
                                                        user.uid)
                                                    ? "You: ${messages[0].message}\n"
                                                    : "${messages[0].message}\n",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      )
                                    : Text(
                                        "\n\n",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                              ),
                              SizedBox(height: 5.0),
                              Divider(
                                thickness: 1.5,
                                color: Color(0xFF95989A).withOpacity(0.2),
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
