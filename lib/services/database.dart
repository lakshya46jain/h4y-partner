// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/models/service_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  // Collection Reference (User Database)
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('H4Y Users Database');

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
        'Account Type': "Professional",
        'User UID': uid,
        'Full Name': fullName,
        'Occupation': occupation,
        'Phone Number': phoneNumber,
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

  // Update Professional Services
  Future updateProfessionalServices(
    String serviceTitle,
    String serviceDescription,
    int servicePrice,
    bool serviceVisibility,
  ) async {
    return await userCollection.doc(uid).collection("Services").doc().set(
      {
        'Professional UID': uid,
        'Service Title': serviceTitle,
        'Service Description': serviceDescription,
        'Service Price': servicePrice,
        'Visibility': serviceVisibility
      },
    );
  }

  // User Data from Snapshot
  UserDataProfessional _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataProfessional(
      uid: uid,
      fullName: snapshot.data()['Full Name'],
      occupation: snapshot.data()['Occupation'],
      phoneNumber: snapshot.data()['Phone Number'],
      phoneIsoCode: snapshot.data()['Phone ISO Code'],
      nonInternationalNumber: snapshot.data()['Non International Number'],
      profilePicture: snapshot.data()['Profile Picture'],
    );
  }

  // Service Data from Snapshot
  List<Help4YouServices> _help4youServicesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (document) {
        Help4YouServices help4youServices = Help4YouServices(
          serviceId: document.id,
          professionalId: document.data()["Professional UID"],
          serviceTitle: document.data()["Service Title"],
          serviceDescription: document.data()["Service Description"],
          servicePrice: document.data()["Service Price"],
          visibility: document.data()["Visibility"],
        );
        return help4youServices;
      },
    ).toList();
  }

  // Get User Document
  Stream<UserDataProfessional> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Service Document
  Stream<List<Help4YouServices>> get serviceData {
    return userCollection
        .doc(uid)
        .collection("Services")
        .snapshots()
        .map(_help4youServicesFromSnapshot);
  }
}
