import 'package:cloud_firestore/cloud_firestore.dart';

// Messages Model
class Messages {
  final String messageId;
  final String sender;
  final String type;
  final String message;
  final bool isRead;
  final Timestamp timeStamp;

  Messages({
    this.messageId,
    this.sender,
    this.type,
    this.message,
    this.isRead,
    this.timeStamp,
  });
}
