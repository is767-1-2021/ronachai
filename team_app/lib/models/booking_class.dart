import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String hospitalName;
  final String checkDate;
  final String result;
  final String fullName;

  Booking(this.hospitalName, this.checkDate, this.result, this.fullName);

  factory Booking.fromDs(
    Map<String, Object?> json,
  ) {
    return Booking(
      json['hospitalName'] as String,
      json['checkDate'] as String,
      json['result'] as String,
      json['fullName'] as String,
    );
  }
}

class AllBookings {
  final List<Booking> bookings;
  AllBookings(this.bookings);

  factory AllBookings.fromSnapshot(QuerySnapshot s) {
    List<Booking> bookings = s.docs.map((DocumentSnapshot ds) {
      return Booking.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllBookings(bookings);
  }
}