// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/loading.dart';
import 'package:h4y_partner/models/messages_model.dart';
import 'package:h4y_partner/secondary_screens/message_screen/app_bar.dart';
import 'package:h4y_partner/secondary_screens/message_screen/message_bubble.dart';
import 'package:h4y_partner/secondary_screens/message_screen/bottom_navigation_bar.dart';

class MessageScreen extends StatefulWidget {
  final String uid;
  final String profilePicture;
  final String fullName;
  final String phoneNumber;

  MessageScreen({
    @required this.uid,
    @required this.profilePicture,
    @required this.fullName,
    @required this.phoneNumber,
  });

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Message Variables
  bool isMessageEmpty;

  // Message Controller
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: MessageAppBar(
            profilePicture: widget.profilePicture,
            fullName: widget.fullName,
            phoneNumber: widget.phoneNumber,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: DatabaseService(uid: user.uid, customerUID: widget.uid)
                    .messagesData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Messages> messages = snapshot.data;
                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 20.0,
                      ),
                      physics: BouncingScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          profilePicture: widget.profilePicture,
                          message: messages[index].message,
                          isSentByMe: (messages[index].sender == user.uid)
                              ? true
                              : false,
                        );
                      },
                    );
                  } else {
                    return DoubleBounceLoading();
                  }
                },
              ),
            ),
            MessageNavBar(
              isMessageEmpty: isMessageEmpty,
              onChanged: (value) {
                if (messageController.text.trim().isEmpty) {
                  setState(() {
                    isMessageEmpty = true;
                  });
                } else if (messageController.text.trim().isNotEmpty) {
                  setState(() {
                    isMessageEmpty = false;
                  });
                }
              },
              onPressed: () async {
                // Create Chat Room In Database
                await DatabaseService(uid: user.uid, customerUID: widget.uid)
                    .createChatRoom();
                // Add Message
                await DatabaseService(uid: user.uid, customerUID: widget.uid)
                    .addMessageToChatRoom(
                  messageController.text.trim(),
                );
                messageController.clear();
                setState(() {
                  isMessageEmpty = true;
                });
              },
              messageController: messageController,
            ),
          ],
        ),
      ),
    );
  }
}
