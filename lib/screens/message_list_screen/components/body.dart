// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/search_bar.dart';
import 'package:h4y_partner/models/chat_room_model.dart';
import 'package:h4y_partner/screens/message_list_screen/components/message_tile.dart';

class MessageListBody extends StatelessWidget {
  final TextEditingController searchController;
  final Help4YouUser user;

  MessageListBody({
    @required this.searchController,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.0,
        ),
        SearchBar(
          width: MediaQuery.of(context).size.width,
          hintText: "Search messages...",
          controller: searchController,
        ),
        SizedBox(
          height: 15.0,
        ),
        Expanded(
          child: StreamBuilder(
            stream: DatabaseService(uid: user.uid).chatRoomsData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ChatRoom> chatRooms = snapshot.data;
                return ListView.builder(
                  itemCount: chatRooms.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MessageTile(
                      uid: chatRooms[index].customerUID,
                      chatRoomId: chatRooms[index].chatRoomId,
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
