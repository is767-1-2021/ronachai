import 'package:flutter/material.dart';

class HospitelFormModel extends ChangeNotifier {
  String? _hospitelName;
  String? _addressName;
  int? _phoneNumber;
  int? _numberPatient;
  int? _numberStaff;
  int? _avaliableQueue;
  int? _allQueue;
  int? _hospitelId;
  //List<BookingItem>? _bookingList;

  String? get hospitelName => this._hospitelName;

  set hospitelName(String? value) {
    this._hospitelName = value;
    notifyListeners();
  }

  get addressName => this._addressName;

  set addressName(value) {
    this._addressName = value;
    notifyListeners();
  }

  get phoneNumber => this._phoneNumber;

  set phoneNumber(value) {
    this._phoneNumber = value;
    notifyListeners();
  }

  get numberPatient => this._numberPatient;

  set numberPatient(value) {
    this._numberPatient = value;
    notifyListeners();
  }

  get numberStaff => this._numberStaff;
  set numberStaff(value) {
    this._numberStaff = value;
    notifyListeners();
  }

   get avaliableQueue => this._avaliableQueue;
  set avaliableQueue(value) {
    this._avaliableQueue = value;
    notifyListeners();
  }

   get allQueu => this._allQueue;
  set allQueu(value) {
    this._allQueue = value;
    notifyListeners();
  }

   get hospitelId => this._hospitelId;
  set hospitelId(value) {
    this._hospitelId = value;
    notifyListeners();
  }
}