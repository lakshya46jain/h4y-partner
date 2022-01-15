// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:h4y_partner/constants/signature_button.dart';
import 'package:h4y_partner/models/booked_services_model.dart';
import 'package:h4y_partner/screens/project_details_screen/components/booked_items_list.dart';
import 'package:h4y_partner/screens/project_details_screen/components/finish_job_button.dart';
import 'package:h4y_partner/screens/project_details_screen/components/accept_reject_button.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String otp;
  final String address;
  final String bookingId;
  final double totalPrice;
  final String customerUID;
  final String professionalUID;
  final String bookingStatus;
  final Timestamp preferredTimings;
  final List<BookedServices> bookedItemsList;
  final String paymentMethod;

  ProjectDetailsScreen({
    @required this.otp,
    @required this.address,
    @required this.bookingId,
    @required this.totalPrice,
    @required this.customerUID,
    @required this.professionalUID,
    @required this.bookingStatus,
    @required this.preferredTimings,
    @required this.bookedItemsList,
    @required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: SignatureButton(type: "Back Button"),
        title: Text(
          "Project Details",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookedItemsList(bookedItemsList: bookedItemsList),
              SizedBox(height: 5.0),
              Divider(thickness: 1.0, color: Color(0xFFFEA700)),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$totalPrice",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Text("Order: #$bookingId", style: TextStyle(fontSize: 15.0)),
              SizedBox(height: 10.0),
              Text(
                "Location: $address (${DateFormat("d MMMM yyyy").format(preferredTimings.toDate().toLocal())} ${DateFormat.jm().format(preferredTimings.toDate().toLocal())})",
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Payment Method: $paymentMethod",
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
      floatingActionButton: (bookingStatus == "Booking Pending")
          ? AcceptRejectButton(
              bookingId: bookingId,
              customerUID: customerUID,
              professionalUID: professionalUID,
            )
          : (bookingStatus == "Accepted")
              ? FinishJobButton(otp: otp, bookingId: bookingId)
              : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
