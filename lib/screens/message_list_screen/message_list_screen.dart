// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/message_list_screen/components/body.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key key}) : super(key: key);

  @override
  MessageListScreenState createState() => MessageListScreenState();
}

class MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Messages",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: MessageListBody(
          user: user,
        ),
      ),
    );
  }
}
