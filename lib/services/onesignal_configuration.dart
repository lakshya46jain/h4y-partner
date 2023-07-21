// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// File Imports

// OneSignal API Configuration Keys
String oneSignalAppID = "e0147524-1283-4702-a8b4-e90e776568c6";
String restAPIKey = "OGJkNTM2MjctYWRkNS00M2M0LWI5Y2YtZjc2OGYxN2Q1ODRl";
String notificatioIcon =
    "https://drive.google.com/uc?export=view&id=1YhqsAs0RXsDei98L_QKiqQWQM0TSluw2";

// Send Notification Function
Future sendNotification(
  String uid,
  String heading,
  String content,
  String notifType,
  String documentID,
) async {
  final userData = await FirebaseFirestore.instance
      .collection("H4Y Users Database")
      .doc(uid)
      .get();

  final tokenIdList =
      List<String>.from(userData.data()?["OneSignal Token IDs"]);

  OSCreateNotification notification = OSCreateNotification(
    playerIds: tokenIdList,
    heading: heading,
    content: content,
    androidSmallIcon: notificatioIcon,
    androidLargeIcon: notificatioIcon,
    additionalData: {
      "Notification Type": notifType,
      "Document ID": documentID,
    },
  );
  await OneSignal.shared.postNotification(notification);
}
