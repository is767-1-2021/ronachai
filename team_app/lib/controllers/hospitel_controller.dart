import 'dart:async';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/services/hospitel_service.dart';

class HospitelController {
  final HospitelServices services;
  List<BookingHospitel> bookinglist = List.empty();

  bool _isDisposed = false;

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

 HospitelController(this.services);

Future<List<BookingHospitel>> fecthHospitelList() async {
  
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    bookinglist = await services.getHospitelList();
    onSyncController.add(false);
    dispose();
    return bookinglist;
  }


    Future<void> updateHospitel(int idcard, String checkindate,String enddateadmit) async {
    await services.updateHospitel(idcard, checkindate, enddateadmit);
    
    }

  void dispose() {
    onSyncController.close();
    _isDisposed = true;
  }
}