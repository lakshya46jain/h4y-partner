// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:h4y_partner/models/booked_services_model.dart';
import 'package:h4y_partner/screens/project_details_screen/project_details_screen.dart';

class BookingTile extends StatelessWidget {
  final String address;
  final String bookingId;
  final double totalPrice;
  final String customerUID;
  final Timestamp preferredTimings;
  final String bookingStatus;
  final List<BookedServices> bookedItemsList;

  BookingTile({
    @required this.address,
    @required this.bookingId,
    @required this.totalPrice,
    @required this.customerUID,
    @required this.preferredTimings,
    @required this.bookingStatus,
    @required this.bookedItemsList,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(customerUID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String profilePicture = snapshot.data["Profile Picture"];
          String fullName = snapshot.data["Full Name"];
          String phoneNumber = snapshot.data["Phone Number"];

          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Container(
                padding: EdgeInsets.all(15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color(0xFFDADADA),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bookingId,
                          style: TextStyle(
                            fontSize: 19.0,
                            color: Color(0xFF1C3857),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(7.5),
                          color: (bookingStatus == "Job Completed")
                              ? Colors.green.withOpacity(0.15)
                              : (bookingStatus == "Accepted")
                                  ? Colors.green.withOpacity(0.15)
                                  : (bookingStatus == "Customer Cancelled")
                                      ? Colors.red.withOpacity(0.15)
                                      : (bookingStatus == "Rejected")
                                          ? Colors.red.withOpacity(0.15)
                                          : Color(0xFFFEA700).withOpacity(0.15),
                          child: Text(
                            bookingStatus,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: (bookingStatus == "Job Completed")
                                  ? Colors.green
                                  : (bookingStatus == "Accepted")
                                      ? Colors.green
                                      : (bookingStatus == "Customer Cancelled")
                                          ? Colors.red
                                          : (bookingStatus == "Rejected")
                                              ? Colors.red
                                              : Color(0xFFFEA700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7.5,
                    ),
                    Text(
                      "${DateFormat("EEE, d MMM, ''yy At h:mm a").format(preferredTimings.toDate().toLocal())}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.64),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(profilePicture),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF1C3857),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.64),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 7.5),
                      child: Container(
                        height: 4.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF95989A).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailsScreen(
                            address: address,
                            bookingId: bookingId,
                            totalPrice: totalPrice,
                            bookingStatus: bookingStatus,
                            preferredTimings: preferredTimings,
                            bookedItemsList: bookedItemsList,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "View Project Details",
                          style: TextStyle(
                            fontSize: 19.0,
                            color: Color(0xFF1C3857),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
