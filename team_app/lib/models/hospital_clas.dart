import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  int? hospitalId;
  String? hospitalName;
  String? addressName;
  int? phoneNumber;
  int? numberPatient;
  int? numberStaff;
  int? avaliableQueue;
  int? allQueue;

  Hospital({
    required this.hospitalId,
    required this.hospitalName,
    required this.phoneNumber,
    required this.numberPatient,
    required this.numberStaff,
    required this.avaliableQueue,
    required this.allQueue,
  });
}

class BHospital {
  int hospital_number;
  String hospital_name;
  String address;
  String phone;
  int no_patient;
  int no_staff;
  int avaliable_queue;
  BHospital(this.hospital_number, this.hospital_name,this.address,this.phone,this.no_patient,this.no_staff,this.avaliable_queue);

  
  factory BHospital.fromDs(
    Map<String, Object?> json,
  ) {
    return BHospital(
      json['hospital_number'] as int,
      json['hospital_name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['no_patient'] as int,
      json['no_staff'] as int,
      json['avaliable_queue'] as int,
    );
  }

  factory BHospital.fromJson(
    Map<String, dynamic> json,
  ) {
    return BHospital(
      json['hospital_number'] as int,
      json['hospital_name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['no_patient'] as int,
      json['no_staff'] as int,
      json['avaliable_queue'] as int,
    );
  }
}

class AllHospitals {
  final List<BHospital> hospitals;
  AllHospitals(this.hospitals);

  factory AllHospitals.fromSnapshot(QuerySnapshot s) {
    List<BHospital> hospitals = s.docs.map((DocumentSnapshot ds) {
      return BHospital.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllHospitals(hospitals);
  }
}

class SingleHospital {
  final BHospital hospital;
  SingleHospital(this.hospital);

  factory SingleHospital.fromJson(QuerySnapshot s) {
    var hospital = s.docs.map((DocumentSnapshot ds) {
      return BHospital.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleHospital(hospital.first);
  }
}
