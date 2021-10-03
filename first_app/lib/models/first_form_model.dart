import 'package:flutter/material.dart';

class FirstFormModel extends ChangeNotifier {
  String? _firstName;
  String? _lastName;
  int? _age;

  String? get firstName => this._firstName;

  set firstName(String? value) {
    this._firstName = value;
    notifyListeners();
  }

  get lastName => this._lastName;

  set lastName(value) {
    this._lastName = value;
    notifyListeners();
  }

  get age => this._age;

  set age(value) {
    this._age = value;
    notifyListeners();
  }
}
