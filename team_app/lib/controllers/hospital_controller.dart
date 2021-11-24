import 'dart:async';

import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/services/hospital_service.dart';

class HospitalController{
  final HospitalServices services;

  // StreamController<bool> onSyncAddHosController = StreamController<bool>.broadcast();
  // Stream<bool> get onSyncAddHosBooking => onSyncAddHosController.stream;

  HospitalController(this.services);

  void addhospitalInfo(BHospital items) async {
    services.addhospitalInfo(items);
  }
}