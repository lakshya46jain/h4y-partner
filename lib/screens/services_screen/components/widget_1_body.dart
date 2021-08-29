import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/loading.dart';
import 'package:h4y_partner/models/service_model.dart';
import 'package:h4y_partner/screens/services_screen/components/service_tile.dart';

class Widget1Body extends StatelessWidget {
  const Widget1Body({
    Key key,
    @required this.user,
    @required this.controller,
  }) : super(key: key);

  final Help4YouUser user;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).serviceListData,
      builder: (context, snapshot) {
        List<Help4YouServices> services = snapshot.data;
        if (snapshot.hasData) {
          if (services.length == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  "assets/graphics/Help4You_Illustration_6.svg",
                ),
              ),
            );
          } else {
            return ListView.builder(
              controller: controller,
              itemCount: services.length,
              padding: EdgeInsets.all(0.0),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ServiceTile(
                  documentId: services[index].serviceId,
                  serviceTitle: services[index].serviceTitle,
                  serviceDescription: services[index].serviceDescription,
                  servicePrice: services[index].servicePrice,
                  visibility: services[index].visibility,
                );
              },
            );
          }
        } else {
          return DoubleBounceLoading();
        }
      },
    );
  }
}