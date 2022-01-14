// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/models/booking_model.dart';
import 'package:h4y_partner/screens/dashboard_screen/components/booking_tile.dart';

class DashboardScreenBody extends StatelessWidget {
  final String bookingStatus;

  DashboardScreenBody({
    @required this.bookingStatus,
  });

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid, bookingStatus: bookingStatus)
          .bookingsListData,
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
              int paymentMethod = bookingsList[index].paymentMethod;
              return BookingTile(
                address: bookingsList[index].address,
                bookingId: bookingsList[index].bookingId,
                customerUID: bookingsList[index].customerUID,
                preferredTimings: bookingsList[index].preferredTimings,
                totalPrice: bookingsList[index].totalPrice,
                bookingStatus: bookingsList[index].bookingStatus,
                bookedItemsList: bookingsList[index].bookedItems,
                paymentMethod: (paymentMethod == 0)
                    ? "Cash Payment"
                    : (paymentMethod == 1)
                        ? "Online Payment"
                        : (paymentMethod == 2)
                            ? "Payment Incomplete"
                            : "",
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
