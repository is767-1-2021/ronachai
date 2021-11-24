import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:icovid/pages/hospital_booking_list.dart';

class PatientFormModelHospitel with ChangeNotifier {
  int? idCard;
  String? firstName;
  String? lastName;
  String? hospital;
  String? hospitel;
  String? phone;
  String? checkindate;
//   TimeOfDay? timeappointment;
//   //May
// int? id;
//   String? pid;
//   String? checkin;
//   String? checkout;
//   String? hName;
//   String? hAddress;
//   String? hTel;
//   String? hBed;
  
List<BookingHospitelItem>? _patientList;

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


   get gethospitel => this.hospitel;

  set sethospitel(hospitel) {
    this.hospitel = hospitel;
    notifyListeners();
  }

  get getphone => this.phone;

  set setphone(phone) {
    this.phone = phone;
    notifyListeners();
  }

 get getdatecheckindate => this.checkindate;

  set setdatecheckindate(checkindate) {
    this.checkindate = checkindate;
    notifyListeners();
  }
   

  // get getcheckin => this.checkin;

  // set setcheckin(checkin) {
  //   this.checkin = checkin;
  //   notifyListeners();
  // }

  // get getcheckout => this.checkout;

  // set setcheckout(checkout) {
  //   this.checkout = checkout;
  //   notifyListeners();
  // }
  
  get patientList => this._patientList;

  set patientList(value) {
    this._patientList = value;
    notifyListeners();
  }

  final List<BookingHospitelItem> _item = [];

  UnmodifiableListView<BookingHospitelItem> get items => UnmodifiableListView(_item);

  List<BookingHospitelItem> getPatientList() {
    return _item;
  }

  void AddPatientList(BookingHospitelItem item) {
    _item.add(item);
    notifyListeners();
  }



// List<PatientHospitel> getPatient() {
//     return Patients;
//   }

//   void addUser(BookingHospitelItem statement) {
//     Patients.add(statement);

//     //users.insert(0, statement); เพิ่มด้านบน
//     //users.add(statement); เพิ่มด้านล่าง
//     notifyListeners();
// // แจ้ง consumer
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

  