import 'package:cloud_firestore/cloud_firestore.dart';

// Booking Model
class Booking {
  final String bookingId;
  final String customerUID;
  final String professionalUID;
  final Timestamp bookingTime;
  final String address;
  final GeoPoint addressGeoPoint;
  final Timestamp preferredTimings;
  final String bookingStatus;
  // Cart Items
  final double totalPrice;

  Booking({
    this.bookingId,
    this.customerUID,
    this.professionalUID,
    this.bookingTime,
    this.address,
    this.addressGeoPoint,
    this.preferredTimings,
    this.bookingStatus,
    // Cart Items
    this.totalPrice,
  });
}
