// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

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
      actionPane: SlidableDrawerActionPane(),
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
            ],
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          color: Color(0xFF1C3857),
          iconWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.edit_24_regular,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Update",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          onTap: () {},
        ),
        IconSlideAction(
          color: Colors.red,
          iconWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.delete_24_regular,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Delete",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          onTap: () async {
            await FirebaseFirestore.instance
                .collection("H4Y Services Database")
                .doc(documentId)
                .delete();
          },
        ),
      ],
    );
  }
}
