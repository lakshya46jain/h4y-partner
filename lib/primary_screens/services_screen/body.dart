// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/service_model.dart';
import 'package:h4y_partner/primary_screens/services_screen/service_tile.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).serviceData,
      builder: (context, snapshot) {
        List<Help4YouServices> services = snapshot.data;
        if (services.length == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / (1792 / 600),
                child: SvgPicture.asset(
                  "assets/graphics/Help4You_Illustration_6.svg",
                ),
              ),
              Text(
                "Oops! Looks like you are not providing any services yet.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: services.length,
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
      },
    );
  }
}
