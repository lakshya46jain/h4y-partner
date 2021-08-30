// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/models/service_model.dart';
import 'package:h4y_partner/models/messages_model.dart';
import 'package:h4y_partner/models/chat_room_model.dart';

class DatabaseService {
  final String uid;
  final String customerUID;
  final String documentId;

  DatabaseService({
    this.uid,
    this.customerUID,
    this.documentId,
  });

  // Collection Reference (User Database)
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('H4Y Users Database');

  // Collection Reference (User Database)
  final CollectionReference servicesCollection =
      FirebaseFirestore.instance.collection('H4Y Services Database');

  // Collection Reference (Chat Room Database)
  final CollectionReference chatRoomCollection =
      FirebaseFirestore.instance.collection("H4Y Chat Rooms Database");

  // Update User Data
  Future updateUserData(
    String fullName,
    String occupation,
    String phoneNumber,
    String phoneIsoCode,
    String nonInternationalNumber,
  ) async {
    return await userCollection.doc(uid).set(
      {
        'Full Name': fullName,
        'Occupation': occupation,
        'Phone Number': phoneNumber,
        'Account Type': "Professional",
        'Phone ISO Code': phoneIsoCode,
        'Non International Number': nonInternationalNumber,
      },
    );
  }

  // Update User Profile Picture
  Future updateProfilePicture(
    String profilePicture,
  ) async {
    return await userCollection.doc(uid).update(
      {
        'Profile Picture': profilePicture,
      },
    );
  }

  // Update User Online Status
  Future updateUserStatus(
    String status,
  ) async {
    await userCollection.doc(uid).update(
      {
        'Status': status,
      },
    );
  }

  // Update Professional Services
  Future createProfessionalServices(
    String serviceTitle,
    String serviceDescription,
    double servicePrice,
    bool serviceVisibility,
  ) async {
    return await servicesCollection.doc().set(
      {
        'Professional UID': uid,
        'Service Title': serviceTitle,
        'Service Description': serviceDescription,
        'Service Price': servicePrice,
        'Visibility': serviceVisibility
      },
    );
  }

  // Update Professional Services
  Future updateProfessionalServices(
    String serviceTitle,
    String serviceDescription,
    double servicePrice,
    bool serviceVisibility,
  ) async {
    return await servicesCollection.doc(documentId).update(
      {
        'Professional UID': uid,
        'Service Title': serviceTitle,
        'Service Description': serviceDescription,
        'Service Price': servicePrice,
        'Visibility': serviceVisibility
      },
    );
  }

  // Create Chat Room
  Future createChatRoom() async {
    DocumentSnapshot ds =
        await chatRoomCollection.doc("$customerUID\_$uid").get();
    if (!ds.exists) {
      await chatRoomCollection.doc("$customerUID\_$uid").set(
        {
          "Connection Date": DateTime.now(),
          "Chat Room ID": "$customerUID\_$uid",
          "Customer UID": customerUID,
          "Professional UID": uid,
        },
      );
    }
  }

  // Add Chat Room Messageszzz
  Future addMessageToChatRoom(
    String message,
  ) async {
    await chatRoomCollection
        .doc("$customerUID\_$uid")
        .collection("Messages")
        .doc()
        .set(
      {
        "Sender": uid,
        "Message": message,
        "Time Stamp": DateTime.now(),
      },
    );
  }

  // User Data from Snapshot
  UserDataProfessional _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataProfessional(
      uid: snapshot.id,
      fullName: snapshot['Full Name'],
      occupation: snapshot['Occupation'],
      phoneNumber: snapshot['Phone Number'],
      phoneIsoCode: snapshot['Phone ISO Code'],
      nonInternationalNumber: snapshot['Non International Number'],
      profilePicture: snapshot['Profile Picture'],
      status: snapshot["Status"],
    );
  }

  // Service List Data from Snapshot
  List<Help4YouServices> _help4youServicesListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (document) {
        Help4YouServices help4youServices = Help4YouServices(
          serviceId: document.id,
          professionalId: document["Professional UID"],
          serviceTitle: document["Service Title"],
          serviceDescription: document["Service Description"],
          servicePrice: document["Service Price"],
          visibility: document["Visibility"],
        );
        return help4youServices;
      },
    ).toList();
  }

  // Service Data from Snapshot
  Help4YouServices _help4youServicesFromSnapshot(DocumentSnapshot snapshot) {
    return Help4YouServices(
      serviceId: snapshot.id,
      professionalId: snapshot["Professional UID"],
      serviceTitle: snapshot["Service Title"],
      serviceDescription: snapshot["Service Description"],
      servicePrice: snapshot["Service Price"],
      visibility: snapshot["Visibility"],
    );
  }

  // Chat Rooms from Snapshot
  List<ChatRoom> _help4YouChatRoomFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map((document) {
      ChatRoom help4YouChatRoom = ChatRoom(
          chatRoomId: document.id,
          connectionDate: document["Connection Date"],
          customerUID: document["Customer UID"],
          professionalUID: document["Professional UID"]);
      return help4YouChatRoom;
    }).toList();
  }

  // Messages Data from Snapshot
  List<Messages> _help4YouMessageFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        Messages help4YouMessages = Messages(
          messageId: document.id,
          sender: document["Sender"],
          message: document["Message"],
          timeStamp: document["Time Stamp"],
        );
        return help4YouMessages;
      },
    ).toList();
  }

  // Get User Document
  Stream<UserDataProfessional> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Service List Document
  Stream<List<Help4YouServices>> get serviceListData {
    return servicesCollection
        .where("Professional UID", isEqualTo: uid)
        .snapshots()
        .map(_help4youServicesListFromSnapshot);
  }

  // Get Service Document
  Stream<Help4YouServices> get serviceData {
    return servicesCollection
        .doc(documentId)
        .snapshots()
        .map(_help4youServicesFromSnapshot);
  }

  // Get Chat Rooms Documents
  Stream<List<ChatRoom>> get chatRoomsData {
    return chatRoomCollection
        .where("Professional UID", isEqualTo: uid)
        .snapshots()
        .map(_help4YouChatRoomFromSnapshot);
  }

  // Get Messages Documents
  Stream<List<Messages>> get messagesData {
    return chatRoomCollection
        .doc("$customerUID\_$uid")
        .collection("Messages")
        .orderBy("Time Stamp", descending: true)
        .snapshots()
        .map(_help4YouMessageFromSnapshot);
  }
}
