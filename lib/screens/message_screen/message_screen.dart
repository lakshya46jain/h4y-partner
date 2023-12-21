// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final String? uid;
  final String? profilePicture;
  final String? fullName;
  final String? phoneNumber;

  const MessageScreen({
    Key? key,
    required this.uid,
    required this.profilePicture,
    required this.fullName,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  void getPermission() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      Permission.notification.request();
    } else if (notificationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  // Message Variables
  bool isMessageEmpty = true;

  // Message Controller
  final TextEditingController messageController = TextEditingController();

  // Active Image File
  File? imageFile;

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
        .child(("H4Y Chat Rooms Media/$fileName"));
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
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
    // Send Notification: Sent a photo
  }

  String? message;
  bool? isSentByMe;
  String? messageId;
  String? chatRoomId;
  String? messageType;
  bool isLongPress = false;

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isLongPress = false;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.5),
          leading: const SignatureButton(type: "Back Button"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFF5F6F9),
                radius: 21.0,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.profilePicture!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                widget.fullName!,
                style: GoogleFonts.balooPaaji2(
                  fontSize: 20.0,
                  color: const Color(0xFF1C3857),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.phone,
                size: 27.0,
                color: Color(0xFFFEA700),
              ),
              onPressed: () {
                FlutterPhoneDirectCaller.callNumber(widget.phoneNumber!);
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: DatabaseService(
            uid: user!.uid,
            customerUID: widget.uid,
          ).messagesData,
          builder: (context, snapshot) {
            List<Messages>? messages = snapshot.data as List<Messages>?;
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 20.0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: messages!.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          groupByDate: (index == messages.length - 1)
                              ? true
                              : (DateFormat.yMd().format(messages[index]
                                          .timeStamp!
                                          .toDate()
                                          .toLocal()) !=
                                      DateFormat.yMd().format(
                                          messages[index + 1]
                                              .timeStamp!
                                              .toDate()
                                              .toLocal()))
                                  ? true
                                  : false,
                          timeStamp: messages[index].timeStamp,
                          chatRoomId: "${widget.uid}_${user.uid}",
                          messageId: messages[index].messageId,
                          type: messages[index].type,
                          profilePicture: widget.profilePicture,
                          message: messages[index].message,
                          isSentByMe: (messages[index].sender == user.uid)
                              ? true
                              : false,
                          isRead: messages[index].isRead,
                          onLongPress: () {
                            setState(() {
                              message = messages[index].message;
                              messageId = messages[index].messageId;
                              chatRoomId = "${widget.uid}_${user.uid}";
                              messageType = messages[index].type;
                              isSentByMe = (messages[index].sender == user.uid)
                                  ? true
                                  : false;
                              (isLongPress == false)
                                  ? isLongPress = true
                                  : isLongPress = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  MessageNavBar(
                    isLongPress: isLongPress,
                    messageType: messageType,
                    isSentByMe: isSentByMe,
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
                    unsendOnTap: () async {
                      if (messageType == "Media") {
                        await FirebaseStorage.instance
                            .refFromURL(message!)
                            .delete();
                      }
                      await FirebaseFirestore.instance
                          .collection("H4Y Chat Rooms Database")
                          .doc(chatRoomId)
                          .collection("Messages")
                          .doc(messageId)
                          .delete();
                      setState(() {
                        isLongPress = false;
                      });
                      // Send Notification: This message is no longer available because it was unsent by the sender.
                    },
                    copySaveOnTap: () async {
                      if (messageType != "Media") {
                        await FlutterClipboard.copy(message!);
                        setState(() {
                          isLongPress = false;
                        });
                      } else {
                        await ImageDownloader.downloadImage(message!);
                        setState(() {
                          isLongPress = false;
                        });
                      }
                    },
                    onPressed: () async {
                      // Create Chat Room In Database
                      await DatabaseService(
                        uid: user.uid,
                        customerUID: widget.uid,
                      ).createChatRoom();
                      // Add Message
                      await DatabaseService(
                        uid: user.uid,
                        customerUID: widget.uid,
                      ).addMessageToChatRoom(
                        "Text",
                        messageController.text.trim(),
                      );
                      // Send Notification: messageController.text.trim()
                      messageController.clear();
                      setState(() {
                        isMessageEmpty = true;
                      });
                    },
                    cameraOnPressed: () => getMedia(ImageSource.camera, user),
                    galleryOnPressed: () => getMedia(ImageSource.gallery, user),
                    messageController: messageController,
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
