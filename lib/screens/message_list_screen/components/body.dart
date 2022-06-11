// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/chat_room_model.dart';
import 'package:h4y_partner/screens/message_list_screen/components/message_tile.dart';

class MessageListBody extends StatelessWidget {
  final Help4YouUser user;

  const MessageListBody({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).chatRoomsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatRoom> chatRooms = snapshot.data;
          return ListView.builder(
            itemCount: chatRooms.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return MessageTile(
                user: user,
                chatRoomId: chatRooms[index].chatRoomId,
                customerUID: chatRooms[index].customerUID,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
