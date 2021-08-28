// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:h4y_partner/screens/message_screen/message_screen.dart';

class MessageTile extends StatelessWidget {
  final String uid;
  final String chatRoomId;

  MessageTile({
    @required this.uid,
    @required this.chatRoomId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(uid)
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
                    uid: uid,
                    profilePicture: profilePicture,
                    fullName: fullName,
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Row(
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
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
                          SizedBox(height: 5),
                          Opacity(
                            opacity: 0.64,
                            child: Text(
                              "Last Message",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.0,
                                fontSize: 16.0,
                                fontFamily: "BalooPaaji",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.64,
                    child: Text(
                      "Time",
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 16.0,
                        fontFamily: "BalooPaaji",
                      ),
                    ),
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
