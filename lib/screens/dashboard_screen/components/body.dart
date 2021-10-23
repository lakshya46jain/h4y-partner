// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/booking_model.dart';
import 'package:h4y_partner/screens/dashboard_screen/components/booking_tile.dart';

class DashboardScreenBody extends StatefulWidget {
  @override
  State<DashboardScreenBody> createState() => _DashboardScreenBodyState();
}

class _DashboardScreenBodyState extends State<DashboardScreenBody> {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).bookingsListData,
      builder: (context, snapshot) {
        List<Booking> bookingsList = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: 0.0,
              bottom: 100.0,
              right: 0.0,
              left: 0.0,
            ),
            itemCount: bookingsList.length,
            itemBuilder: (context, index) {
              return BookingTile(
                bookingId: bookingsList[index].bookingId,
                customerUID: bookingsList[index].customerUID,
                preferredTimings: bookingsList[index].preferredTimings,
                bookingStatus: bookingsList[index].bookingStatus,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
