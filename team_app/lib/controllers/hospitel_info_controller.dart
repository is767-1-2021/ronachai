import 'dart:async';

import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/models/hospitel_info_class.dart';
import 'package:icovid/services/hospitel_info_service.dart';

class HospitelInfoController{
  final HospitelInfoServices services;

  // StreamController<bool> onSyncAddHosController = StreamController<bool>.broadcast();
  // Stream<bool> get onSyncAddHosBooking => onSyncAddHosController.stream;

  HospitelInfoController(this.services);

  void addhospitelInfo(BHospitel items) async {
    services.addhospitelInfo(items);
  }
}