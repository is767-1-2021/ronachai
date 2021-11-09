
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/patient_class.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'hospital_booking_list.dart';

class ScanQR_Page extends StatelessWidget {
  const ScanQR_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'บันทึกการเข้ารับการตรวจ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
        ),
        backgroundColor: iBlueColor,
      ),
      body: qrScan(),
    );
  }
}

class qrScan extends StatefulWidget {
  const qrScan({Key? key}) : super(key: key);

  @override
  _qrScanState createState() => _qrScanState();
}

class _qrScanState extends State<qrScan> {
  //String qrString = "Not Scanned";
  double? height, width;
  //String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());


  // Future<void> _openDatepickerstart(BuildContext context) async {
  //   final DateTime? d = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: new DateTime(2017),
  //       lastDate: new DateTime(2030));

  //   if (d != null) {
  //     setState(() {
  //       startdate = DateFormat('dd-MM-yyyy').format(d);
  //       _dateappointment = d;
  //     });
  //   }
  // }

  // DateTime date = DateTime.now();
  // TimeOfDay time = TimeOfDay.now();
  // Future<Null> selectDatePicker(BuildContext context) async {
  //   final DateTime? datePicked = await showDatePicker(
  //       context: context,
  //       initialDate: date,
  //       firstDate: DateTime(1940),
  //       lastDate: DateTime(2030));
  //   if (datePicked != null && datePicked != date) {
  //     setState(() {
  //       date = datePicked;
  //       _dateappointment = date;
  //     });
  //   }
  // }

  final _formkey = GlobalKey<FormState>();
  int? _idCard;
  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _hospital;
  String? _dateappointment;
  var qrString ="1234567891012 panita tharaphum 0825467891 โรงพยาบาลบำรุงราษฏร์ 28/9/2021 23:0:0'";

  @override
  Widget build(BuildContext context) {
    var parts = qrString.split(' ');
    var idcard = parts[0].trim(); // prefix: "date"
    var qrfirstname = parts[1].trim();
    var qrlastname = parts[2].trim();
    var qrphone = parts[3].trim();
    var qrhospital = parts[4].trim();
    var qrdateappointment = parts[5].trim();
    //var date = parts.sublist(0).join('').trim();

    return Form(
        key: _formkey,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'หมายเลขบัตรประจำตัวประชาชน',
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
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุเลขที่บัตรประจำตัวประชาชน';
                      }
                      if (!isNumeric(value)) {
                        return 'กรุณาระบุตัวเลขเท่านั้น';
                      }
                      if (value.length != 13) {
                        return 'กรุณาระบุให้ครบ 13 หลัก';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _idCard = int.parse(value!);
                    },
                    initialValue: (context.read<PatientFormModel>().idCard ==
                            null)
                        ? idcard
                        : context.read<PatientFormModel>().idCard.toString(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'ชื่อ',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุชื่อ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstName = value;
                    },
                    initialValue: (context.read<PatientFormModel>().firstName ==
                            null)
                        ? qrfirstname
                        : context.read<PatientFormModel>().firstName
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'นามสกุล',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุนามสกุล';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lastName = value;
                    },
                     initialValue: (context.read<PatientFormModel>().lastName ==
                            null)
                        ? qrlastname
                        : context.read<PatientFormModel>().lastName
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'เบอร์โทรศัพท์',                                                                          
                      hintText: 'กรอกเฉพาะตัวเลข 10 หลักติดกันไม่ต้องมีขีดขั้น',
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
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุเบอร์โทรศัพท์';
                      }
                      if (!isNumeric(value)) {
                        return 'กรุณาระบุตัวเลขเท่านั้น';
                      }
                      if (value.length != 10) {
                        return 'กรุณาระบุให้ครบ 10 หลัก';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phone = (value);
                    },
                 initialValue: (context.read<PatientFormModel>().phone ==
                            null)
                        ? qrphone
                        : context.read<PatientFormModel>().phone
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'สถานที่',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุสถานที่';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _hospital = value;
                    },
                     initialValue: (context.read<PatientFormModel>().hospital ==
                            null)
                        ? qrhospital
                        : context.read<PatientFormModel>().hospital
                  ),TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'วันที่',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุวันที่';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _dateappointment = value;
                    },
                     initialValue: (context.read<PatientFormModel>().dateappointment ==
                            null)
                        ? qrdateappointment
                        : context.read<PatientFormModel>().dateappointment
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 280),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      // BorderRadius: new BorderRadius.circular(30.0),

                      //height: 60,
                      // color: iBlueColor,
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          //รับค่าจาก ProfileModel -> TextFormField -> BookingModel
                          context.read<PatientFormModel>().idCard = _idCard;
                          context.read<PatientFormModel>().firstName =
                              _firstName;
                          context.read<PatientFormModel>().lastName = _lastName;
                          context.read<PatientFormModel>().hospital = _hospital;
                          context.read<PatientFormModel>().phone = _phone;
                          context.read<PatientFormModel>().dateappointment = _dateappointment;

                           List<Patient> Listpatient = [];
                           if (context.read<PatientFormModel>().patientList != null) {
                           print( '||||');
                          Listpatient = context.read<PatientFormModel>().patientList;
                        }
                           Listpatient.add(Patient(
                             idCard: 11,
                            firstName:  _firstName,
                            lastName: _lastName,
                            phone: _phone,
                            dateappointment:  _dateappointment
                        
                            
                            )
                        );
                        
                        context.read<PatientFormModel>().patientList = Listpatient;
                        _showDialog(context);
                      }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HospitalBookingsList()));
                        }
                      ,
                      style: ElevatedButton.styleFrom(
                        primary: iBlueColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('ถัดไป',
                          style: TextStyle(fontSize: 20, color: iWhiteColor)),
                    ),
                  ),
                  Text(qrString),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        // floatingActionButton: FloatingActionButton(
                        onPressed: scanQR,
                        child: Icon(Icons.qr_code_outlined),
                      ),
                    ],
                  )
                ])));
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancle", true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrString = value;
          //qrString = "panita tharaphom";
        });
      });
    } catch (e) {
      setState(() {});
    }
  }

  bool isNumeric(String value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final number = num.tryParse(value);
    if (number == null) {
      return false;
    }
    return true;
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('สำเร็จ'),
        content: Text('คุณได้เพิ่มผู้ใช้งานเรียบร้อยแล้ว'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HospitalBookingsList())
                );
              },
              child: Text('ตกลง'))
        ],
      );
    },
  );
}

  // _showTimePicker(BuildContext context) async {
  //   TimeOfDay? time =
  //       await showTimePicker(context: context, initialTime: _time);

  //   if (time != null)
  //     setState(() {
  //       _time = time;
  //     });
  //   else {
  //     setState(() {
  //       _time = TimeOfDay.now();
  //     });
  //   }
  // }

