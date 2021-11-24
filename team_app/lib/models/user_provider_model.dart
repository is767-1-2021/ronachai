import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? _email;
  String? _first_name;
  String? _last_name;
  String? _password;
  String? _position;
  String? _roleId;
  String? _roleName;
  String? _hospital_id;
  String? _hospital_name;

  get email => this._email;

  set email(value) {
    this._email = value;
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

  get password => this._password;

  set password(value) {
    this._password = value;
    notifyListeners();
  }

  get position => this._position;

  set position(value) {
    this._position = value;
    notifyListeners();
  }

  get roleId => this._roleId;

  set roleId(value) {
    this._roleId = value;
    notifyListeners();
  }

  get roleName => this._roleName;

  set roleName(value) {
    this._roleName = value;
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
}
