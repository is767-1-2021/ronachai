import 'dart:async';

import 'package:final_app/models/calculator_model.dart';
import 'package:final_app/services/calculator_services.dart';

class CalculatorController {
  final Services services;
  List<Calculator> historyList = List.empty();
  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  bool _isDisposed = false;

  CalculatorController(this.services);

  Future<List<Calculator>> fetchHistory() async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    historyList = await services.getHistory();
    onSyncController.add(false);
    dispose();
    return historyList;
  }

  Future<void> addHistory(String _historyValue, String _resultValue) async {
    await services.addHistory(_historyValue, _resultValue);
  }

  void dispose() {
    onSyncController.close();
    _isDisposed = true;
  }
}
