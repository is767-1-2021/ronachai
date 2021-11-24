import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icovid/models/hospital_clas.dart';

abstract class AHospitalService{
  Future<void> addhospitalInfo(BHospital _hospital);
}
class HospitalServices extends AHospitalService {
   CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_hospital');

  @override
  Future<void> addhospitalInfo(BHospital items) {
   return _ref.add({
      'hospital_number': items.hospital_number,
      'hospital_name': items.hospital_name,
      'address': items.address,
      'no_patient': items.no_patient,
      'no_staff': items.no_staff,
      'phone': items.phone,
      'avaliable_queue': items.no_patient,
    });
  }

}