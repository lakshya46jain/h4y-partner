// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/messages_model.dart';
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/screens/message_screen/components/message_bubble.dart';
import 'package:h4y_partner/screens/message_screen/components/bottom_nav_bar.dart';

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
  bool isMessageEmpty = true;

  // Message Controller
  final TextEditingController messageController = TextEditingController();

  // Active Image File
  File imageFile;

  // Select Image Via Image Picker
  Future getMedia(ImageSource source, user) async {
    await ImagePicker().pickImage(source: source).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadMedia(user);
      }
    });
  }

  Future uploadMedia(user) async {
    Navigator.pop(context);
    var fileNameGenerator = RandomStringGenerator(
      fixedLength: 20,
      hasAlpha: true,
      hasDigits: true,
      hasSymbols: false,
    ).generate();
    String fileName = fileNameGenerator.toString();
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(("H4Y Chat Rooms Media/" + fileName));
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    await uploadTask;
    String downloadAddress = await firebaseStorageRef.getDownloadURL();
    // Create Chat Room In Database
    await DatabaseService(uid: user.uid, customerUID: widget.uid)
        .createChatRoom();
    // Add Message
    await DatabaseService(uid: user.uid, customerUID: widget.uid)
        .addMessageToChatRoom(
      "Media",
      downloadAddress,
    );
  }

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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.5),
          leading: SignatureButton(type: "Back Button"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFF5F6F9),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.profilePicture,
                    fit: BoxFit.fill,
                  ),
                ),
                radius: 21.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                widget.fullName,
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "BalooPaaji",
                  color: Color(0xFF1C3857),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.phone,
                size: 27.0,
                color: Color(0xFFFEA700),
              ),
              onPressed: () {
                FlutterPhoneDirectCaller.callNumber(widget.phoneNumber);
              },
            ),
          ],
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
                          chatRoomId: "${user.uid}\_${widget.uid}",
                          messageId: messages[index].messageId,
                          type: messages[index].type,
                          profilePicture: widget.profilePicture,
                          message: messages[index].message,
                          isSentByMe: (messages[index].sender == user.uid)
                              ? true
                              : false,
                        );
                      },
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
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
                  "Text",
                  messageController.text.trim(),
                )
                    .then(
                  (value) {
                    messageController.clear();
                    setState(() {
                      isMessageEmpty = true;
                    });
                  },
                );
              },
              cameraOnPressed: () => getMedia(ImageSource.camera, user),
              galleryOnPressed: () => getMedia(ImageSource.gallery, user),
              messageController: messageController,
            ),
          ],
        ),
      ),
    );
  }
}
