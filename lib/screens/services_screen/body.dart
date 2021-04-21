// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/screens/services_screen/service_tile.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(user.uid)
          .collection("Services")
          .snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
            return ServiceTile(
              documentId: documentSnapshot.id,
              serviceTitle: documentSnapshot["Service Title"],
              serviceDescription: documentSnapshot["Service Description"],
              servicePrice: documentSnapshot["Service Price"],
              visibility: documentSnapshot["Visibility"],
            );
          },
        );
      },
    );
  }
}
