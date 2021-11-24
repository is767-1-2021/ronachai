import 'package:cloud_firestore/cloud_firestore.dart';

class HospitelInfo {
  int? hospitelId;
  String? hospitelName;
  String? addressName;
  int? phoneNumber;
  int? numberPatient;
  int? numberStaff;

  HospitelInfo({
    required this.hospitelId,
    required this.hospitelName,
    required this.phoneNumber,
    required this.numberPatient,
    required this.numberStaff,
  });
}

class BHospitel {
  int hospitel_number;
  String hospitel_name;
  String address;
  String phone;
  int no_patient;
  int no_staff;
  BHospitel(this.hospitel_number, this.hospitel_name,this.address,this.phone,this.no_patient,this.no_staff);

  
  factory BHospitel.fromDs(
    Map<String, Object?> json,
  ) {
    return BHospitel(
      json['hospitel_number'] as int,
      json['hospitel_name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['no_patient'] as int,
      json['no_staff'] as int,
    );
  }

  factory BHospitel.fromJson(
    Map<String, dynamic> json,
  ) {
    return BHospitel(
      json['hospitel_number'] as int,
      json['hospitel_name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['no_patient'] as int,
      json['no_staff'] as int,
    );
  }
}

class AllHospitels {
  final List<BHospitel> hospitels;
  AllHospitels(this.hospitels);

  factory AllHospitels.fromSnapshot(QuerySnapshot s) {
    List<BHospitel> hospitels = s.docs.map((DocumentSnapshot ds) {
      return BHospitel.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllHospitels(hospitels);
  }
}

class SingleHospitel {
  final BHospitel hospitel;
  SingleHospitel(this.hospitel);

  factory SingleHospitel.fromJson(QuerySnapshot s) {
    var hospital = s.docs.map((DocumentSnapshot ds) {
      return BHospitel.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleHospitel(hospital.first);
  }
}
