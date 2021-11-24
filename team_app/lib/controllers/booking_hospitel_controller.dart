import 'dart:async';

import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/hospitel_info_class.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/pages/hospital_booking_list.dart';
import 'package:icovid/services/booking_hospitel_service.dart';

class BookingHospitelController {
  final BookingHospitelServices services;
  List<BookingHospitelList> bookinglist = List.empty();
  List<BHospitel> hospitelList = List.empty();

  Booking? bookings; 
  bool _isDisposed = false;

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  BookingHospitelController(this.services);

  // Future<List<BookingHospitel>> fecthCheckin(String hospital) async {
    Future<Booking?> fecthCheckin(String idcard) async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    // bookings = await services.getCheckin(hospital);
    print(idcard);
    bookings = await services.getCheckin(idcard);
    onSyncController.add(false);
    dispose();
    return bookings;
  }

Future<List<BookingHospitelList>> fecthCheckinList() async {
  
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    // bookings = await services.getCheckin(hospital);
    bookinglist = await services.getCheckinList();
    onSyncController.add(false);
    dispose();
    return bookinglist;
  }




  void addBookingHospitel(BookingHospitelItem items) async {
    services.addBookingHospitel(items);
  }
    Future<void> updateHospitel(int idcard, String checkindate,String hospitel) async {
    await services.updateHospitel(idcard, checkindate, hospitel);
    
    }

    Future<void> updateResultPatient(int idcard, String checkindate,String result) async {
    await services.updateResultPatient(idcard, checkindate,result);
    
    }

    Future<List<BHospitel>> fecthHospitelList() async {
      hospitelList = await services.getHospitelList();
      print('hos:${hospitelList[0].hospitel_name}');
      return hospitelList;
    }

  void dispose() {
    onSyncController.close();
    _isDisposed = true;
  }
}