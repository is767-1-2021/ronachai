import 'dart:async';

import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/services/booking_service.dart';

class BookingController {
  final BookingServices services;
  List<Booking> bookings = List.empty();
  List<BHospital> hospitalList = List.empty();

  StreamController<bool> onSyncController = StreamController<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;
  bool _isDisposed = false;

  BookingController(this.services);

  Future<List<Booking>?> fecthBookings(String idCardNumber) async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.sink.add(true);
    bookings = await services.getBookingsById(idCardNumber);
    onSyncController.sink.add(false);
    dispose();
    return bookings;
  }

  void addBooking(Booking items) async {
    print('controller_booking:${items.bookingNumber}');
    services.addBooking(items);
  }

  Future<List<BHospital>> fecthHospitalList() async {
    hospitalList = await services.getHospitalList();
    return hospitalList;
  }

  void updateAvaliableQueue(int hostpitalNumber, int avaliableQueue) {
    services.updateAvaliableQueue(hostpitalNumber, avaliableQueue);
  }

  void cancelQueue(String idCardNumber, int bookingNumber, int hospitalNumber) async {
    BHospital hospital = await services.getCurrentQueue(hospitalNumber);
    services.setActiveQueue(idCardNumber, bookingNumber);
    services.cancelQueue(hospitalNumber, hospital.avaliable_queue + 1);
  }

  void dispose() {
    onSyncController.close();
    _isDisposed = true;
  }
}
