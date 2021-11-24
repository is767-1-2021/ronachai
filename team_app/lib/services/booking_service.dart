import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/hospital_clas.dart';

abstract class ABooking {
  Future<List<Booking>> getBookingsById(String idCardNumber);
  Future<List<Booking>> getBookingsByHospitalNumber(int hospitalNumber);
  Future<void> addBooking(Booking items);
  Future<List<BHospital>> getHospitalList();
  Future<void> updateAvaliableQueue(int hospitalNumber, int avaliableQueue);
  Future<void> cancelQueue(int hopitalNumber, int newQueueNumber);
  Future<void> setActiveQueue(String idCardNumber, int bookingNumber);
  Future<BHospital> getCurrentQueue(int hospitalNumber);
}

class BookingServices extends ABooking {
  CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_booking');

  @override
  Future<List<Booking>> getBookingsById(String idCardNumber) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('icovid_booking')
        .where('idCardNumber', isEqualTo: idCardNumber)
        .where('isActive', isEqualTo: true)
        .orderBy('bookingNumber', descending: false)
        .get();

    AllBookings bookings = AllBookings.fromSnapshot(snapshot);
    return bookings.bookings;
  }

  @override
  Future<List<Booking>> getBookingsByHospitalNumber(int hospitalNumber) async {
    print('hospitalNumber:${hospitalNumber}');
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('icovid_booking')
        .where('hospitalNumber', isEqualTo: hospitalNumber)
        .where('isActive', isEqualTo: true)
        .orderBy('bookingNumber', descending: false)
        .get();

    AllBookings bookings = AllBookings.fromSnapshot(snapshot);
    return bookings.bookings;
  }

  @override
  Future<void> addBooking(Booking items) {
    return _ref.add({
      'checkDate': items.checkDate,
      'fullName': items.fullName,
      'hospitalName': items.hospitalName,
      'result': items.result,
      'idCardNumber': items.idCardNumber,
      'bookingNumber': items.bookingNumber,
      'hospitalNumber': items.hospitalNumber,
      'isActive': true,
      'createDate':DateTime.now()
    });
    //.then((value) => print('Booking Added'))
    //.catchError((error) => print("Failed to add Booking: $error"));
  }

  @override
  Future<List<BHospital>> getHospitalList() async {
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection('icovid_hospital').get();
    AllHospitals hospitals = AllHospitals.fromSnapshot(snapshot);
    return hospitals.hospitals;
  }

  @override
  Future<void> updateAvaliableQueue(int hostpitalNumber, int avaliableQueue) async {
    CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_hospital');
    FirebaseFirestore.instance
        .collection('icovid_hospital')
        .where('hospital_number', isEqualTo: hostpitalNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref.doc(doc.id).update({'avaliable_queue': avaliableQueue});
      });
    });
  }

  @override
  Future<void> cancelQueue(int hospitalNumber, int newQueueNumber) async {
    print('hospitalNumber:${hospitalNumber}');
    print('newQueueNumber:${newQueueNumber}');
    CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_hospital');
    FirebaseFirestore.instance
        .collection('icovid_hospital')
        .where('hospital_number', isEqualTo: hospitalNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref.doc(doc.id).update({'avaliable_queue': newQueueNumber});
      });
    });
  }

  @override
  Future<void> setActiveQueue(String idCardNumber, int bookingNumber) async {
    CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_booking');
    FirebaseFirestore.instance
        .collection('icovid_booking')
        .where('bookingNumber', isEqualTo: bookingNumber)
        .where('idCardNumber', isEqualTo: idCardNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref.doc(doc.id).update({'isActive': false});
      });
    });
  }

  @override
  Future<BHospital> getCurrentQueue(int hospitalNumber) async {
    QuerySnapshot snapshot = await FirebaseFirestore
    .instance
    .collection('icovid_hospital')
    .where('hospital_number',isEqualTo: hospitalNumber)
    .get();
    SingleHospital hospital = SingleHospital.fromJson(snapshot);
    return hospital.hospital;
  }
}
