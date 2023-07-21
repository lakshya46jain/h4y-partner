import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h4y_partner/models/booked_services_model.dart';

// Booking Model
class Booking {
  final String? bookingId;
  final String? customerUID;
  final String? professionalUID;
  final Timestamp? bookingTime;
  final String? address;
  final GeoPoint? addressGeoPoint;
  final Timestamp? preferredTimings;
  final String? bookingStatus;
  final List<BookedServices>? bookedItems;
  final int? paymentMethod;
  final String? otp;
  final double? totalPrice;

  Booking({
    this.bookingId,
    this.customerUID,
    this.professionalUID,
    this.bookingTime,
    this.address,
    this.addressGeoPoint,
    this.preferredTimings,
    this.bookingStatus,
    this.bookedItems,
    this.paymentMethod,
    this.otp,
    this.totalPrice,
  });
}
