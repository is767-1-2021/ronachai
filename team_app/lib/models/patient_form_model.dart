import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icovid/pages/hospital_booking_list.dart';

import 'patient_class.dart';

class BookingHospitel {
  final int idcard;
  final String fullname;
  final String phone;
  final String hospital;
  final String checkindate;
  final String hospitel;
  final String startdateadmit;
  final String enddateadmit;
  final String status;

  BookingHospitel(this.idcard, this.fullname, this.phone,this.hospital,this.checkindate,this.hospitel,
      this.startdateadmit, this.enddateadmit, this.status);
  factory BookingHospitel.fromDs(
    Map<String, Object?> json,
  ) {
    return BookingHospitel(
      json['idcard'] as int,
      json['fullname'] as String,
      json['phone'] as String,
      json['hospital'] as String,
      json['checkindate'] as String,
      json['hospitel'] as String,
      json['startdateadmit'] as String,
      json['enddateadmit'] as String,
      json['status'] as String,
    );
  }
}
class AllBookingHospitel {
  final List<BookingHospitel> bookings;
  AllBookingHospitel(this.bookings);

  factory AllBookingHospitel.fromSnapshot(QuerySnapshot s) {
    List<BookingHospitel> bookingsHospitel = s.docs.map((DocumentSnapshot ds) {
      return BookingHospitel.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllBookingHospitel(bookingsHospitel);
  }
}



// CheckinList

class BookingHospitelList {
   String hospitalName;
  String checkDate;
  String result;
  String fullName;
  int hospitalNumber;
  String idCardNumber;
  int bookingNumber;
 

  BookingHospitelList(this.hospitalName, this.checkDate, this.result, this.fullName,
      this.hospitalNumber, this.idCardNumber, this.bookingNumber);

  factory BookingHospitelList.fromDs(
    Map<String, Object?> json,
  ) {
    return BookingHospitelList(
      json['hospitalName'] as String,
      json['checkDate'] as String,
      json['result'] as String,
      json['fullName'] as String,
      json['hospitalNumber'] as int,
      json['idCardNumber'] as String,
      json['bookingNumber'] as int,
    );
  }
}

class AllBookingHospitelList {
  final List<BookingHospitelList> bookings;
  AllBookingHospitelList(this.bookings);

  factory AllBookingHospitelList.fromSnapshot(QuerySnapshot s) {
    List<BookingHospitelList> bookingsHospitel = s.docs.map((DocumentSnapshot ds) {
      return BookingHospitelList.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllBookingHospitelList(bookingsHospitel);
  }
}


class PatientFormModel with ChangeNotifier {
  // ใช้อันนี้
  int? idCard;
  String? firstName;
  String? lastName;
  String? hospital;
  String? hospitel;
  String? phone;
  String? checkindate;
  String? startdateadmit;
  String? enddateadmit;
  String? status;
  //TimeOfDay? timeappointment;
  //May
  int? id;
  String? pid;
  String? checkin;
  String? checkout;
  String? hName;
  String? hAddress;
  String? hTel;
  String? hBed;

  //List<BookingHospitelItem>? _patientList;

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

  get getcheckindate => this.checkindate;

  set setcheckindate(checkindate) {
    this.checkindate = checkindate;
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

  get getstartdateadmit => this.startdateadmit;

  set setstartdateadmit(startdateadmit) {
    this.startdateadmit = startdateadmit;
    notifyListeners();
  }

  get getenddateadmit => this.enddateadmit;

  set setenddateadmit(enddateadmit) {
    this.enddateadmit = enddateadmit;
    notifyListeners();
  }

    get getstatus => this.status;

  set setstatus(status) {
    this.status = status;
    notifyListeners();
  }


  // get patientList => this._patientList;

  // set patientList(value) {
  //   this._patientList = value;
  //   notifyListeners();
  // }

  final List<BookingHospitelItem> _item = [];

  UnmodifiableListView<BookingHospitelItem> get items => UnmodifiableListView(_item);

  List<BookingHospitelItem> getBookingHospitelList() {
    return _item;
  }

  void AddPatientList(BookingHospitelItem item) {
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