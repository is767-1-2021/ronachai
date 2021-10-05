import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  int? _id_card;
  String? _first_name;
  String? _last_name;
  String? _tel;
  String? _email;
  String? _password;

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

  get email => this._email;

  set email(value) {
    this._email = value;
    notifyListeners();
  }

  get password => this._password;

  set password (value) {
    this._password = value;
    notifyListeners();
  }
}
