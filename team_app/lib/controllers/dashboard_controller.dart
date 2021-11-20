import 'dart:async';

import 'package:icovid/models/dashboard_model.dart';
import 'package:icovid/services/dashboard_service.dart';

class DashboardController {
  final HttpServices services;
  List<CovidStat> stats = List.empty();
  bool _isDisposed = false;
  
  StreamController<bool> onSyncHttpService = StreamController();
  Stream<bool> get onSyncService => onSyncHttpService.stream;

  DashboardController(this.services);

  Future<List<CovidStat>> getCovidStatistics() async {
    if(_isDisposed) {
      onSyncHttpService = StreamController();
    }
    onSyncHttpService.add(true);
    stats = await services.getCovidStatistics();
    onSyncHttpService.add(false);
    return stats;
  }

  void dispose() {
    onSyncHttpService.close();
    _isDisposed = true;
  }
}
