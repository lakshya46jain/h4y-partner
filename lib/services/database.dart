// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  // Collection Reference (User Database)
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('H4Y Users Database');

  // Update User Data
  Future updateUserData(
    String fullName,
    String occupation,
    String phoneNumber,
    String phoneIsoCode,
    String nonInternationalNumber,
  ) async {
    return await customerCollection.doc(uid).set(
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
    return await customerCollection.doc(uid).update(
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
    return await customerCollection.doc(uid).collection("Services").doc().set(
      {
        'User UID': uid,
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

  // Get User Document
  Stream<UserDataProfessional> get userData {
    return customerCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
