
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icovid/models/booking_class.dart';

abstract class Services {
  Future<List<Booking>> getBookings();
}

class  FirebaseServices extends Services {
  @override
  Future<List<Booking>> getBookings() async {
      QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('icovid_booking').get();

    AllBookings bookings = AllBookings.fromSnapshot(snapshot);
    return bookings.bookings;
  }
  
}