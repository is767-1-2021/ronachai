import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/models/calculator_model.dart';

abstract class Services {
  Future<void> addHistory(String _historyValue, String _resultValue);
  Future<List<Calculator>> getHistory();
}

class FirebaseServices extends Services {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('calculator_history');

  @override
  Future<void> addHistory(String _historyValue, String _resultValue) {
    return _ref.add({
      'resultValue': _resultValue,
      'historyValue': _historyValue,
      'createDate': DateTime.now()
    });
  }

  @override
  Future<List<Calculator>> getHistory() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('calculator_history')
        //.where('createDate')
        .orderBy('createDate',descending: true)
        .get();
    AllHistory histories = AllHistory.fromSnapshot(snapshot);
    return histories.histories;
  }
}
