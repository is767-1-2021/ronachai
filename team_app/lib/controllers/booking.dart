import 'dart:async';

import 'package:icovid/models/booking_class.dart';
import 'package:icovid/services/service.dart';

class BookingController {
  final Services services;
  List<Booking> bookings = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  BookingController(this.services);
  
  
  Future<List<Booking>> fecthBookings() async {
    onSyncController.add(true);
    bookings = await services.getBookings();
    onSyncController.add(false);
    return bookings;
  }
}
