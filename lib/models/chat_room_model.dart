// Chat Room Model
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String chatRoomId;
  final Timestamp connectionDate;
  final String customerUID;
  final String professionalUID;

  ChatRoom({
    this.chatRoomId,
    this.connectionDate,
    this.customerUID,
    this.professionalUID,
  });
}