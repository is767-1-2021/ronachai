import 'dart:collection';

import 'package:flutter/material.dart';

import 'patient_class.dart';

class PatientFormModel with ChangeNotifier {
  int? idCard;
  String? firstName;
  String? lastName;
  String? hospital;
  String? phone;
  String? dateappointment;
  TimeOfDay? timeappointment;
  //May
int? id;
  String? pid;
  String? checkin;
  String? checkout;
  String? hName;
  String? hAddress;
  String? hTel;
  String? hBed;
  
List<Patient>? _patientList;

 get getidCard => this.idCard;

  set setidCard(idCard) {
    this.idCard = idCard;
    notifyListeners();
  } 
  get getfirstName => this.firstName;

  set setfirstName(firstName) {
    this.firstName = firstName;
    notifyListeners();
  } 

  get getlastName => this.lastName;

  set getlastName(lastName) {
    this.lastName = lastName;
    notifyListeners();
  } 

  get gethospital => this.hospital;

  set sethospital(hospital) {
    this.hospital = hospital;
    notifyListeners();
  }

  get getphone => this.phone;

  set setphone(phone) {
    this.phone = phone;
    notifyListeners();
  }

 get getdateappointment => this.dateappointment;

  set setdateappointment(dateappointment) {
    this.dateappointment = dateappointment;
    notifyListeners();
  }
   

  get getcheckin => this.checkin;

  set setcheckin(checkin) {
    this.checkin = checkin;
    notifyListeners();
  }

  get getcheckout => this.checkout;

  set setcheckout(checkout) {
    this.checkout = checkout;
    notifyListeners();
  }
  
  get patientList => this._patientList;

  set patientList(value) {
    this._patientList = value;
    notifyListeners();
  }

  final List<Patient> _item = [];

  UnmodifiableListView<Patient> get items => UnmodifiableListView(_item);

  List<Patient> getPatientList() {
    return _item;
  }

  void AddPatientList(Patient item) {
    _item.add(item);
    notifyListeners();
  }


  List<Patient> Patients = [
    Patient(
      idCard: 111,
        firstName: "ronnachia@gmail.com",
        lastName: "Ronnachia Jumsil",
        phone: "Admin",
      
    ),
  ];
List<Patient> getPatient() {
    return Patients;
  }

  void addUser(Patient statement) {
    Patients.add(statement);

    //users.insert(0, statement); เพิ่มด้านบน
    //users.add(statement); เพิ่มด้านล่าง
    notifyListeners();
// แจ้ง consumer
  }
}


  // void RemoveUserList(Patient item) {
  //   _item.remove(item);
  //   notifyListeners();
  // }

  // get pid => this.pid;

  // set pid(value) {
  //   this.pid = value;
  //   notifyListeners();
  // }

  // get hName => this.hName;

  // set hName(value) {
  //   this.hName = value;
  //   notifyListeners();
  // }

  // get hAddress => this.hAddress;

  // set hAddress(value) {
  //   this.hAddress = value;
  //   notifyListeners();
  // }

  // get hTel => this.hTel;

  // set hTel(value) {
  //   this.hTel = value;
  //   notifyListeners();
  // }