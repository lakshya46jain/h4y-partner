// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class ServiceTile extends StatelessWidget {
  final String serviceTitle;
  final String serviceDescription;
  final int servicePrice;
  final bool visibility;

  ServiceTile({
    this.serviceTitle,
    this.serviceDescription,
    this.servicePrice,
    this.visibility,
  });
  @override
  Widget build(BuildContext context) {
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
                      CupertinoSwitch(
                        value: visibility,
                        onChanged: (bool newValue) {
                          // TODO: Set the new value to firebase
                        },
                        activeColor: Colors.deepOrangeAccent,
                      ),
                    ],
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
                onTap: () {
                  // TODO: Give functionality to Edit Button.
                },
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
