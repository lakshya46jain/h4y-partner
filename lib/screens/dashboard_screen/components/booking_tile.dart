// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:h4y_partner/screens/message_screen/message_screen.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:h4y_partner/models/booked_services_model.dart';
import 'package:h4y_partner/screens/project_details_screen/project_details_screen.dart';

class BookingTile extends StatelessWidget {
  final String? otp;
  final String? address;
  final String? bookingId;
  final double? totalPrice;
  final String? customerUID;
  final String? professionalUID;
  final Timestamp? preferredTimings;
  final String? bookingStatus;
  final List<BookedServices>? bookedItemsList;
  final String? paymentMethod;

  const BookingTile({
    Key? key,
    required this.otp,
    required this.address,
    required this.bookingId,
    required this.totalPrice,
    required this.customerUID,
    required this.professionalUID,
    required this.preferredTimings,
    required this.bookingStatus,
    required this.bookedItemsList,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(customerUID)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String profilePicture = snapshot.data["Profile Picture"];
          String fullName = snapshot.data["Full Name"];
          String phoneNumber = snapshot.data["Phone Number"];

          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
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
                          bookingId!,
                          style: const TextStyle(
                            fontSize: 19.0,
                            color: Color(0xFF1C3857),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(7.5),
                          color: (bookingStatus == "Job Completed")
                              ? Colors.green.withOpacity(0.15)
                              : (bookingStatus == "Accepted")
                                  ? Colors.green.withOpacity(0.15)
                                  : (bookingStatus == "Customer Cancelled")
                                      ? Colors.red.withOpacity(0.15)
                                      : (bookingStatus == "Rejected")
                                          ? Colors.red.withOpacity(0.15)
                                          : const Color(0xFFFEA700)
                                              .withOpacity(0.15),
                          child: Text(
                            bookingStatus!,
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
                                              : const Color(0xFFFEA700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7.5),
                    Text(
                      DateFormat("EEE, d MMM, ''yy At h:mm a")
                          .format(preferredTimings!.toDate().toLocal()),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.64),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 75.0,
                              width: 75.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    profilePicture,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF1C3857),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
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
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1C3857),
                          ),
                          child: Center(
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(CupertinoIcons.chat_bubble_fill),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MessageScreen(
                                      uid: customerUID,
                                      profilePicture: profilePicture,
                                      fullName: fullName,
                                      phoneNumber: phoneNumber,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 7.5),
                      child: Container(
                        height: 4.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF95989A).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailsScreen(
                            otp: otp,
                            address: address,
                            bookingId: bookingId,
                            totalPrice: totalPrice,
                            customerUID: customerUID,
                            professionalUID: professionalUID,
                            bookingStatus: bookingStatus,
                            preferredTimings: preferredTimings,
                            bookedItemsList: bookedItemsList,
                            paymentMethod: paymentMethod,
                          ),
                        ),
                      ),
                      child: const Center(
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
