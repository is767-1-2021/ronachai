import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icovid/models/patient_form_model.dart';


abstract class HospitelServices {
  
  Future<List<BookingHospitel>> getHospitelList();
  Future<void> updateHospitel(int _idcard, String _checkindate,String _enddateadmit);
}

class FirebaseServiceHospitelPatient extends HospitelServices {
  CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_booking_hospitel');

@override
   Future<List<BookingHospitel>> getHospitelList() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('icovid_booking_hospitel')
   // .where('isActive', isEqualTo: true)
     //.where('hospital', isEqualTo: hospital)
        //.orderBy('bookingNumber', descending: false)
        .get();

    AllBookingHospitel bookings = AllBookingHospitel.fromSnapshot(snapshot);
    return bookings.bookings;
  }

  
 @override
  Future<void> updateHospitel(int _idcard, String _checkindate, String _enddateadmit) async {
  print(_idcard);
    print(_checkindate);
      print(_enddateadmit);
  
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
              .update({'enddateadmit': _enddateadmit});
         });
    });
  }

}