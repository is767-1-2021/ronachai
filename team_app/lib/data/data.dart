import 'package:icovid/models/hospital_clas.dart';

final prevention = [
  {'assets/images/distance.png': 'เว้น\nระยะห่าง'},
  {'assets/images/wash_hands.png': 'ล้าง\nมือบ่อยๆ'},
  {'assets/images/mask.png': 'สวมหน้า\nกากอนามัย'},
];
final stepSection = [
  {'assets/images/distance.png': 'เว้น\nระยะห่าง'},
  {'assets/images/wash_hands.png': 'ล้าง\nมือบ่อยๆ'},
  {'assets/images/mask.png': 'สวมหน้า\nกากอนามัย'},
];

final List<Hospital> hostpitalListData = [
    Hospital(
        hospitalId: 1,
        hospitalName: 'โรงพยาบาลเกษมราษฏร์ประชาชื่น',
        avaliableQueue: 10,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 2,
        hospitalName: 'โรงพยาบาลบำรุงราษฎร์',
        avaliableQueue: 20,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 3,
        hospitalName: 'โรงพยาบาลวิภาวดี',
        avaliableQueue: 30,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 4,
        hospitalName: 'โรงพยาบาลกรุงเทพ',
        avaliableQueue: 40,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 5,
        hospitalName: 'โรงพยาบาลธนบุรี',
        avaliableQueue: 50,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 6,
        hospitalName: 'สถานพยาบาลผู้ป่วยเฉพาะกิจ1',
        avaliableQueue: 30,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 7,
        hospitalName: 'สถานพยาบาลผู้ป่วยเฉพาะกิจ2',
        avaliableQueue: 30,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
  ];

  final List<Hospital> hostpitalListBooking = [
    Hospital(
        hospitalId: 1,
        hospitalName: 'โรงพยาบาลเกษมราษฏร์ประชาชื่น',
        avaliableQueue: 10,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 2,
        hospitalName: 'โรงพยาบาลบำรุงราษฎร์',
        avaliableQueue: 20,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 3,
        hospitalName: 'โรงพยาบาลวิภาวดี',
        avaliableQueue: 30,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 4,
        hospitalName: 'โรงพยาบาลกรุงเทพ',
        avaliableQueue: 40,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
    Hospital(
        hospitalId: 5,
        hospitalName: 'โรงพยาบาลธนบุรี',
        avaliableQueue: 50,
        allQueue: 100,
        phoneNumber: 023456789,
        numberPatient: 200,
        numberStaff: 50),
  ];