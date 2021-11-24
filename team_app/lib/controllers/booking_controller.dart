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
  StreamController<bool> onSyncHosBookingController = StreamController<bool>.broadcast();
  Stream<bool> get onSyncHosBooking => onSyncHosBookingController.stream;
  bool _isDisposed = false;

  BookingController(this.services);

  Future<List<Booking>> fecthMyBookings(String idCardNumber) async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.sink.add(true);
    bookings = await services.getBookingsById(idCardNumber);
    onSyncController.sink.add(false);
    dispose();
    return bookings;
  }

    Future<List<Booking>> fecthBookingByHospitalNumber(int hospitalNumber) async {
    if (_isDisposed) {
      onSyncHosBookingController = StreamController<bool>.broadcast();
    }
    onSyncHosBookingController.sink.add(true);
    bookings = await services.getBookingsByHospitalNumber(hospitalNumber);
    onSyncHosBookingController.sink.add(false);
    dispose();
    return bookings;
  }

  void addBooking(Booking items) async {
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
    onSyncHosBookingController.close();
    _isDisposed = true;
  }
}
