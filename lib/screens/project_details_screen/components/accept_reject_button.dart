// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/services/database.dart';

class AcceptRejectButton extends StatelessWidget {
  final String bookingId;
  final String customerUID;
  final String professionalUID;

  AcceptRejectButton({
    @required this.bookingId,
    @required this.customerUID,
    @required this.professionalUID,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await DatabaseService(bookingId: bookingId)
                .updateBookingStatus("Accepted");
          },
          color: Colors.green,
          child: Text(
            "Accept",
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MaterialButton(
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await DatabaseService(bookingId: bookingId)
                .updateBookingStatus("Rejected");
            await DatabaseService(
              customerUID: customerUID,
              uid: professionalUID,
            ).addMessageToChatRoom(
              "Text",
              "Dear Customer, I apologize for rejecting the request. Due to my tight schedule, I will be unable to undertake your project.",
            );
          },
          color: Colors.red,
          child: Text(
            "Reject",
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}