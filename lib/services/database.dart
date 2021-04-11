// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports

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
        'Non Internation Number': nonInternationalNumber,
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
}
