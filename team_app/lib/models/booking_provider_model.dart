import 'dart:collection';

import 'package:flutter/material.dart';

import 'booking_class_model.dart';

class BookingProvider extends ChangeNotifier {
  String? hospitalName;
  String? checkDate;
  String? result;
  String? fullName;
  int? bookingNumber;
  String? idCardNumber;
  int? hospitalNumber;
  List<Booking>? _bookingList;
  List<Booking>? _bookingHospitalList;

  get getHospitalName => this.hospitalName;

  set setHospitalName(hospitalName) {
    this.hospitalName = hospitalName;
    notifyListeners();
  }

  get getCheckDate => this.checkDate;

  set setCheckDate(checkDate) {
    this.checkDate = checkDate;
    notifyListeners();
  }

  get getResult => this.result;

  set setResult(result) {
    this.result = result;
    notifyListeners();
  }

  get getFullName => this.fullName;

  set setFullName(fullName) {
    this.fullName = fullName;
    notifyListeners();
  }

  get getBookingNumber => this.bookingNumber;

  set setBookingNumber(bookingNumber) {
    this.bookingNumber = bookingNumber;
    notifyListeners();
  }

  get getIdCardNumber => this.idCardNumber;

  set setIdCardNumber(idCardNumber) {
    this.idCardNumber = idCardNumber;
    notifyListeners();
  }

  get getHospitalNumber => this.hospitalNumber;

  set setHospitalNumber(hospitalNumber) {
    this.hospitalNumber = hospitalNumber;
    notifyListeners();
  }

  get bookingList => this._bookingList;

  set bookingList(value) {
    this._bookingList = value;
    notifyListeners();
  }

  get bookingHospitalList => this._bookingHospitalList;

  set bookingHospitalList(value) {
    this._bookingHospitalList = value;
    notifyListeners();
  }

  final List<Booking> _item = [];

  UnmodifiableListView<Booking> get items => UnmodifiableListView(_item);

  List<Booking> getBookingList() {
    return _item;
  }

  void AddBookingList(Booking item) {
    _item.add(item);
    notifyListeners();
  }
}


// class BookingListModel extends ChangeNotifier {
//   String? _hospital_name;
//   String? _check_date;
//   String? _result;
//   String? get hospital_name => this._hospital_name;
//   List<Booking>? _bookingList;

//   set hospital_name(String? value) {
//     this._hospital_name = value;
//     notifyListeners();
//   }

//   get check_date => this._check_date;

//   set check_date(value) {
//     this._check_date = value;
//     notifyListeners();
//   }

//   get result => this._result;

//   set result(value) {
//     this._result = value;
//     notifyListeners();
//   }

//   get bookingList => this._bookingList;

//   set bookingList(value) {
//     this._bookingList = value;
//     notifyListeners();
//   }

//   final List<Booking> _item = [];

//   UnmodifiableListView<Booking> get items => UnmodifiableListView(_item);

//   List<Booking> getBookingList() {
//     return _item;
//   }

//   void AddBookingList(Booking item) {
//     _item.add(item);
//     notifyListeners();
//   }
// }

