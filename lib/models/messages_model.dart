// Messages Model
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String messageId;
  final String sender;
  final String message;
  final Timestamp timeStamp;

  Messages({
    this.messageId,
    this.sender,
    this.message,
    this.timeStamp,
  });
}
