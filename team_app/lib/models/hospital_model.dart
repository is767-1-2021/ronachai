import 'package:flutter/material.dart';

import 'hospital_clas.dart';

class HospitalFormModel extends ChangeNotifier {
  String? _hospitalName;
  String? _addressName;
  int? _phoneNumber;
  int? _numberPatient;
  int? _numberStaff;
  int? _avaliableQueue;
  int? _allQueue;
  int? _hospitalId;
  List<Hospital>? _hospitalList;

  String? get hospitalName => this._hospitalName;

  set hospitalName(String? value) {
    this._hospitalName = value;
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

   get hospitalId => this._hospitalId;
  set hospitalId(value) {
    this._hospitalId = value;
    notifyListeners();
  }

  get hospitalList => this._hospitalList;

  set hospitalList(value) {
    this._hospitalList = value;
    notifyListeners();
  }
}
