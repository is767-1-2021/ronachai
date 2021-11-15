
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Firebase
class Booking {
  final String hospitalName;
  final String checkDate;
  final String result;
  final String fullName;

  Booking(this.hospitalName, this.checkDate, this.result, this.fullName);

  factory Booking.fromDs(
    Map<String, Object?> json,
  ) {
    return Booking(
      json['hospitalName'] as String,
      json['checkDate'] as String,
      json['result'] as String,
      json['fullName'] as String,
    );
  }
}

class AllBookings {
  final List<Booking> bookings;
  AllBookings(this.bookings);

  factory AllBookings.fromSnapshot(QuerySnapshot s) {
    List<Booking> bookings = s.docs.map((DocumentSnapshot ds) {
      return Booking.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllBookings(bookings);
  }
}


//State
class BookingModel extends ChangeNotifier {
  int? _id_card;
  String? _first_name;
  String? _last_name;
  String? _tel;
  String? _hospital_id;
  String? _hospital_name;
  String? _booking_date;
  String? _booking_time;
  int _queue_number = 0;
  int? get id_card => this._id_card;

  set id_card(int? value) {
    this._id_card = value;
    notifyListeners();
  }

  get first_name => this._first_name;

  set first_name(value) {
    this._first_name = value;
    notifyListeners();
  }

  get last_name => this._last_name;

  set last_name(value) {
    this._last_name = value;
    notifyListeners();
  }

  get tel => this._tel;

  set tel(value) {
    this._tel = value;
    notifyListeners();
  }

  get hospital_id => this._hospital_id;

  set hospital_id(value) {
    this._hospital_id = value;
    notifyListeners();
  }

  get hospital_name => this._hospital_name;

  set hospital_name(value) {
    this._hospital_name = value;
    notifyListeners();
  }

  get booking_date => this._booking_date;

  set booking_date(value) {
    this._booking_date = value;
    notifyListeners();
  }

  get booking_time => this._booking_time;

  set booking_time(value) {
    this._booking_time = value;
    notifyListeners();
  }

  get queue_number => this._queue_number;

  set queue_number(value) {
    this._queue_number = value;
    notifyListeners();
  }
}
