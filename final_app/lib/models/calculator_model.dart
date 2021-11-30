import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Calculator {
  final String historyValue;
  final String resultValue;
  final DateTime createDate;

  Calculator(this.historyValue, this.resultValue,this.createDate);
  factory Calculator.fromJson(
    Map<String, dynamic> json,
  ) {
    return Calculator(
      json['historyValue'] as String,
      json['resultValue'] as String,
      json['createDate']!.toDate() as DateTime,
    );
  }
}

class AllHistory {
  final List<Calculator> histories;
  AllHistory(this.histories);

  factory AllHistory.fromSnapshot(QuerySnapshot s) {
    List<Calculator> histories = s.docs.map((DocumentSnapshot ds) {
      return Calculator.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllHistory(histories);
  }
}

class CalculatorModel extends ChangeNotifier {
  List<Calculator>? historyList;
  List<Calculator>? get getHistoryList => this.historyList;

  set setHistoryList(List<Calculator>? historyList) {
    this.historyList = historyList;
    notifyListeners();
  }
}
