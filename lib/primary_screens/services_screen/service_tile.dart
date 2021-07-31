// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';

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
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceTitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    serviceDescription,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price : $servicePrice",
                      ),
                      IconButton(
                        icon: Icon(
                          FluentIcons.delete_24_regular,
                          color: Colors.red,
                          size: 26.0,
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("H4Y Users Database")
                              .doc(user.uid)
                              .collection("Services")
                              .doc(documentId)
                              .delete();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF5F6F9),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.eye_show_24_regular,
                          size: 30.0,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Service Visibility",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoSwitch(
                          value: visibility,
                          onChanged: (bool newValue) {},
                          activeColor: Colors.deepOrangeAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -15,
            top: -10,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 92),
              width: MediaQuery.of(context).size.width / (828 / 92),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5F6F9),
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                  ),
                  child: Icon(
                    FluentIcons.edit_24_regular,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
