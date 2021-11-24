import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_controller.dart';
import 'package:icovid/models/booking_provider_model.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/services/booking_service.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class HospitalBookingList extends StatefulWidget {
  var service = BookingServices();
  var controller;
  HospitalBookingList() {
    controller = BookingController(service);
  }
 
  @override
  _HospitalBookingListState createState() => _HospitalBookingListState();
}

class _HospitalBookingListState extends State<HospitalBookingList> {
  List<Booking> _bookingHosList = [];
  bool isLoading = false;
  int hospital_number_test = 1000;
   @override
  void initState() {
    super.initState();
    widget.controller.onSync.listen((bool syncState) => setState(() => isLoading = syncState));
  }

  void _getBookings(BuildContext context) async {
    var bookingHospitalList = await widget.controller.fecthBookingByHospitalNumber(hospital_number_test);
    setState(() {
        context.read<BookingProvider>().bookingHospitalList = bookingHospitalList;
    });
  }

  void _cancelQueue(String idCardNumber, int bookingNumber, int hopitalNumber,BuildContext context) async {
    await widget.controller.cancelQueue(idCardNumber, bookingNumber, hopitalNumber);
    var bookingHospitalList = await widget.controller.fecthBookingByHospitalNumber(hospital_number_test);
    setState(() {
      context.read<BookingProvider>().bookingHospitalList = bookingHospitalList;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _bookingHosList.isEmpty ? 1 : _bookingHosList.length,
          itemBuilder: (context, index) {
            if (_bookingHosList.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 300),
                      child: Text('ไม่พบรายการจอง')));
            }
            return Card(
              child: ListTile(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('แจ้งเตือน'),
                          content: Text(
                              'ยืนยันการยกเลิกคิวที่ ${_bookingHosList[index].bookingNumber}'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('ยกเลิก')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _cancelQueue(
                                        _bookingHosList[index].idCardNumber,
                                        _bookingHosList[index].bookingNumber,
                                        _bookingHosList[index].hospitalNumber,
                                        context);
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('ยืนยัน')),
                          ],
                        );
                      });
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // content: Text(' ถูกลบ')));
                },
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text(
                      '${_bookingHosList[index].bookingNumber}',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                title: Text('${_bookingHosList[index].hospitalName}'),
                subtitle: Text('วันที่ตรวจ ${_bookingHosList[index].checkDate}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingDetail(items: _bookingHosList[index]),
                    ),
                  );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    _getBookings(context);
    if (context.read<BookingProvider>().bookingHospitalList != null) {
      _bookingHosList = context.read<BookingProvider>().bookingHospitalList;
    }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'รายชื่อผู้เข้ารับการตรวจ',
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen())
                );
              },
            ),
          ],
          backgroundColor: Color(0xFF473F97),
        ),
        //
        body: Center(
          child: body,
        )
    );
  }
}

class BookingDetail extends StatelessWidget {
  final Booking items;
  const BookingDetail({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'รายละเอียดการจอง',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
          ),
        ),
        backgroundColor: Color(0xFF473F97),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'คิวที่',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.bookingNumber}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'โรงพยาบาลที่เข้ารับการตรวจ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.hospitalName}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'วันที่เข้ารับการตรวจ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.checkDate}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ผลการตรวจ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.result}',
            ),
          ],
        ),
      ),
    );
  }
}
// class PatientDetail extends StatefulWidget {
  
//   final Patient Patients;
  
//   const PatientDetail({Key? key, required this.Patients}) : super(key: key);

//   @override
//   _PatientDetailState createState() => _PatientDetailState();
// }

// class _PatientDetailState extends State<PatientDetail> {
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('รายละเอียดผู้เข้ารับการตรวจ'),
//         backgroundColor: iBlueColor,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => LogInScreen()),
//               // );
//             },
//             icon: Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0), 
//         child: Form(
//             key: formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 enabled: false,
//                 labelText: 'ชื่อ-นามสกุล',
//                 labelStyle: TextStyle(
//                     color: iBlackColor,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//               ),
//               initialValue: '${widget.Patients.firstName}'  '${widget.Patients.lastName}',
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 enabled: false,
//                 labelText: 'วันที่เข้ารับการตรวจเชื้อ',
//                 labelStyle: TextStyle(
//                     color: iBlackColor,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//               ),
//               initialValue: '${widget.Patients.dateappointment}',
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 enabled: false,
//                 labelText: 'เบอร์โทรศัพท์ผู้ป่วย',
//                 labelStyle: TextStyle(
//                     color: iBlackColor,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//               ),
//               initialValue: '${widget.Patients.phone}',
//             ),
            
//             Divider(),
//             TextFormField(
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 enabled: false,
//                 labelText: 'วันที่เข้ารับการตรวจ',
//                 labelStyle: TextStyle(
//                     color: iBlackColor,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: iBlueColor),
//                 ),
//               ),
//               initialValue: '${widget.Patients.dateappointment}',
//             ),
//             Container(
//                     // margin: EdgeInsets.only(top: 280),
//                     width: MediaQuery.of(context).size.width,
//                     child: ElevatedButton(
//                       // BorderRadius: new BorderRadius.circular(30.0),

//                       //height: 60,
//                       // color: iBlueColor,
//                       onPressed: () { 
//                         if (formKey.currentState!.validate()) {
//                           formKey.currentState!.save();

//                           //รับค่าจาก ProfileModel -> TextFormField -> BookingModel
//                          // context.read<PatientFormModel>().idCard = _idCard;
//                           context.read<PatientFormModelHospitel>().firstName =
//                              '${widget.Patients.firstName}';
//                           context.read<PatientFormModelHospitel>().lastName = '${widget.Patients.lastName}';
//                           context.read<PatientFormModelHospitel>().hospital = '${widget.Patients.hospital}';
//                           context.read<PatientFormModelHospitel>().phone = '${widget.Patients.phone}';
//                           context.read<PatientFormModelHospitel>().dateappointment = '${widget.Patients.dateappointment}';

//                            List<PatientHospitel> Listpatient = [];
//                            if (context.read<PatientFormModelHospitel>().patientList != null) {
                          
//                           Listpatient = context.read<PatientFormModelHospitel>().patientList;
//                         }
//                            Listpatient.add(PatientHospitel(
//                              idCard: 11,
//                             firstName:  '${widget.Patients.firstName}',
//                             lastName: '${widget.Patients.lastName}',
//                             phone: '${widget.Patients.phone}',
//                             dateappointment: '${widget.Patients.dateappointment}'
                        
                            
//                             )
//                         );
                        
//                         context.read<PatientFormModelHospitel>().patientList = Listpatient;
                      
//                       }
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Result_Page()));
//                         }
//                       ,
//                       style: ElevatedButton.styleFrom(
//                         primary: iBlueColor,
//                         shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(30.0),
//                         ),
//                       ),
//                       child: Text('บันทึกผลการตรวจ',
//                           style: TextStyle(fontSize: 20, color: iWhiteColor)),
//                     ),
//                   )
//           ],
//         ),
//       ),
//     ));
//   }
// }