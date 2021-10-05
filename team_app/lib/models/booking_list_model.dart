import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:icovid/pages/ubooking_list_page.dart';

class BookingListModel extends ChangeNotifier {
  String? _hospital_name;
  String? _check_date;
  String? _result;
  String? get hospital_name => this._hospital_name;
  List<BookingItem>? _bookingList;

  set hospital_name(String? value) {
    this._hospital_name = value;
    notifyListeners();
  }

  get check_date => this._check_date;

  set check_date(value) {
    this._check_date = value;
    notifyListeners();
  }

  get result => this._result;

  set result(value) {
    this._result = value;
    notifyListeners();
  }

  get bookingList => this._bookingList;

  set bookingList(value) {
    this._bookingList = value;
    notifyListeners();
  }

  final List<BookingItem> _item = [];

  UnmodifiableListView<BookingItem> get items => UnmodifiableListView(_item);

  List<BookingItem> getBookingList() {
    return _item;
  }

  void AddBookingList(BookingItem item) {
    _item.add(item);
    notifyListeners();
  }
}
