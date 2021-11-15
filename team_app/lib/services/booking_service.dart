import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:icovid/pages/ubooking_list_page.dart';

abstract class BookingServices {
  Future<List<Booking>> getBookings();
  Future<void> addBooking(BookingItem items);
}

class FirebaseServices extends BookingServices {
  CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_booking');

  @override
  Future<List<Booking>> getBookings() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('icovid_booking').get();

    AllBookings bookings = AllBookings.fromSnapshot(snapshot);
    return bookings.bookings;
  }

  @override
  Future<void> addBooking(BookingItem items) {
    print('items.fullName:${items.fullName}');
    return _ref.add({
      'checkDate': items.checkDate,
      'fullName': items.fullName,
      'hospitalName': items.hospitalName,
      'result': items.result,
    });
    //.then((value) => print('Booking Added'))
    //.catchError((error) => print("Failed to add Booking: $error"));
  }
}
