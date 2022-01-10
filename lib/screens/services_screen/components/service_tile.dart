// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// File Imports
import 'package:h4y_partner/screens/service_screens/edit_service_screen.dart';

class ServiceTile extends StatelessWidget {
  final String documentId;
  final String serviceTitle;
  final String serviceDescription;
  final double servicePrice;
  final bool visibility;

  ServiceTile({
    this.documentId,
    this.serviceTitle,
    this.serviceDescription,
    this.servicePrice,
    this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceTitle,
                style: TextStyle(
                  fontSize: 21.0,
                  color: Color(0xFF1C3857),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$servicePrice",
                style: TextStyle(
                  color: Color(0xFF1C3857),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                serviceDescription,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF95989A),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3.0,
                color: Color(0xFF95989A).withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Color(0xFF1C3857),
            icon: CupertinoIcons.pencil,
            label: "Update",
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditServiceScreen(
                    documentId: documentId,
                  ),
                ),
              );
            },
          ),
          SlidableAction(
            backgroundColor: Colors.red,
            icon: CupertinoIcons.delete,
            label: "Delete",
            onPressed: (context) async {
              await FirebaseFirestore.instance
                  .collection("H4Y Services Database")
                  .doc(documentId)
                  .delete();
            },
          ),
        ],
      ),
    );
  }
}
