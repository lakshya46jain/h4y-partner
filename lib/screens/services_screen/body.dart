// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/service_model.dart';
import 'package:h4y_partner/screens/services_screen/service_tile.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).serviceData,
      builder: (context, snapshot) {
        List<Help4YouServices> services = snapshot.data;
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
      },
    );
  }
}
