import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/models/hospitel_info_class.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/pages/hospital_booking_list.dart';


abstract class BookingHospitelServices {
  Future<Booking> getCheckin(String idcard);
  Future<List<BookingHospitelList>> getCheckinList();
  Future<void> addBookingHospitel(BookingHospitelItem items);
  Future<void> updateHospitel(int _idcard, String _checkindate,String _hospitel);
  Future<void> updateResultPatient(int _idcard, String _checkindate,String _result);
  Future<List<BHospitel>> getHospitelList() ;
}

class FirebaseServiceHospitel extends BookingHospitelServices {
  CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_booking_hospitel');

  @override
 //Future<List<BookingHospitel>> getCheckin(String hospital) async {
   Future<Booking> getCheckin(String idcard) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('icovid_booking')
    .where('idCardNumber', isEqualTo: idcard)
        //.orderBy('bookingNumber', descending: false)
        .get();
print('ssss'+idcard);
    SingleBooking bookings = SingleBooking.fromJson(snapshot);
    return bookings.booking;
  }

@override
 //Future<List<BookingHospitel>> getCheckin(String hospital) async {
   Future<List<BookingHospitelList>> getCheckinList() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('icovid_booking')
    .where('isActive', isEqualTo: true)
     //.where('hospital', isEqualTo: hospital)
        //.orderBy('bookingNumber', descending: false)
        .get();

    AllBookingHospitelList bookings = AllBookingHospitelList.fromSnapshot(snapshot);
    return bookings.bookings;
  }
 @override
  Future<BHospital> getCurrentQueue(int hospitalNumber) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('icovid_hospital').get();
    SingleHospital hospital = SingleHospital.fromJson(snapshot);
    return hospital.hospital;
  }


  @override
  Future<void> addBookingHospitel(BookingHospitelItem items) {
    //print('items.fullName:${items.fullName}');
    return _ref.add({
      'idcard': items.idCard,
      'fullname': items.fullname,
      'phone': items.phone,
      'hospital': items.hospital,
      'checkindate': items.checkindate,
      'hospitel': items.hospitel,
      'startdateadmit': items.startdateadmit,
      'enddateadmit': items.enddateadmit,
      'status': items.status
    });
   
    //.then((value) => print('Booking Added'))
    //.catchError((error) => print("Failed to add Booking: $error"));
  }
 @override
  Future<void> updateHospitel(int _idcard, String _checkindate,String _hospitel) async {
    CollectionReference _ref = await FirebaseFirestore.instance.collection('icovid_booking_hospitel');
    FirebaseFirestore.instance
        .collection('icovid_booking_hospitel')
        .where('idcard', isEqualTo: _idcard ) 
        .where('checkindate', isEqualTo: _checkindate )
        .get()
        .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _ref
              .doc(doc.id)
              .update({'hospitel': _hospitel});
         });
    });
  }

   @override
  Future<void> updateResultPatient(int _idcard, String _checkindate, String _result) async {
    bool isActive = true;
    CollectionReference _ref = await FirebaseFirestore.instance.collection('icovid_booking');
    print(_idcard);
    print('Ser'+_checkindate);
    FirebaseFirestore.instance
        .collection('icovid_booking')
        .where('idCardNumber', isEqualTo: _idcard.toString() ) 
        .where('checkDate', isEqualTo: _checkindate )
        .where('isActive', isEqualTo: isActive )
        .get()
        .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _ref
              .doc(doc.id)
              .update({'result': _result});
         });
    });
  }

  @override
  Future<List<BHospitel>> getHospitelList() async {
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection('icovid_hospitel').get();
    AllHospitels hospitels = AllHospitels.fromSnapshot(snapshot);
    return hospitels.hospitels;
  }

}