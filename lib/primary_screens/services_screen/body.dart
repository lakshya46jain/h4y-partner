// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/loading.dart';
import 'package:h4y_partner/models/service_model.dart';
import 'package:h4y_partner/constants/custom_tab_bar.dart';
import 'package:h4y_partner/primary_screens/services_screen/service_tile.dart';

class Body extends StatelessWidget {
  final ScrollController controller;

  Body({
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: CustomTabBar(
        text1: "Services",
        text2: "Rate Card",
        widget1: StreamBuilder(
          stream: DatabaseService(uid: user.uid).serviceData,
          builder: (context, snapshot) {
            List<Help4YouServices> services = snapshot.data;
            if (snapshot.hasData) {
              if (services.length == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / (1792 / 600),
                        child: SvgPicture.asset(
                          "assets/graphics/Help4You_Illustration_6.svg",
                        ),
                      ),
                      Text(
                        "Oops! Looks like you are not providing any services",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "BalooPaaji",
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  controller: controller,
                  itemCount: services.length,
                  padding: EdgeInsets.all(0.0),
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
        ),
        widget2: Container(),
      ),
    );
  }
}
