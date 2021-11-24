
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_hospitel_controller.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/models/patient_form_model_hospitel.dart';
import 'package:icovid/services/booking_hospitel_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'hospital_booking_list.dart';

class ScanQR_Page extends StatefulWidget {
  var service = FirebaseServiceHospitel();
  var controller;
  ScanQR_Page() {
    controller = BookingHospitelController(service);
  }
  
  @override
  _ScanQR_PageState createState() => _ScanQR_PageState();
}

class _ScanQR_PageState extends State<ScanQR_Page> {
  Booking? checkin ;
  bool isLoading = false;
 String? idcard;
String? a ;

@override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
      
  }

   void _getCheckin(a) async {
    var checkinlist = await widget.controller.fecthCheckin(a);
    setState(() {
      checkin = checkinlist;
      print('ll'+_idcardController.text);
      _fullnameController.text = '${checkin!.fullName}';
       _hospitalController.text = '${checkin!.hospitalName}';
       _checkdateController.text = '${checkin!.checkDate}';
       String a =_idcardController.text;
          });
  }
double? height, width;
  
  final _formkey = GlobalKey<FormState>();
  int? _idCard;
  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _hospital;
  String? _checkindate;

   
  // var qrString ="1234567891012 panita tharaphum 0825467891 โรงพยาบาลบำรุงราษฏร์ 28/9/2021 23:0:0'";
  //   var parts = qrString.split(' ');
  //   var idcard = parts[0].trim(); // prefix: "date"
  //   var qrfirstname = parts[1].trim();
  //   var qrlastname = parts[2].trim();
  //   var qrphone = parts[3].trim();
  //   var qrhospital = parts[4].trim();
  //   var qrdateappointment = parts[5].trim();
    //var date = parts.sublist(0).join('').trim();

final TextEditingController _fullnameController = new TextEditingController();
final TextEditingController _hospitalController = new TextEditingController();
 final TextEditingController _checkdateController = new TextEditingController();
 final TextEditingController _idcardController = new TextEditingController();
 
 
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
      body:   Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'กรอกหมายเลขบัตรประจำตัวประชาชน',
                        labelStyle: TextStyle(
                            color: iBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                     controller: _idcardController,
                      maxLength: 13,
                      validator: (value) {
                        idcard = value;
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
                      // initialValue: (context.read<PatientFormModel>().idCard ==
                      //         null)
                      //     ? idcard
                      //     : context.read<PatientFormModel>().idCard.toString(),
                    ),ElevatedButton(
                          // floatingActionButton: FloatingActionButton(
                            
                          onPressed:  ()=> _getCheckin(_idcardController.text),
                          child: Icon(Icons.search),
                        ),
                     // Text(_idcardController.text),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     labelText: 'หมายเลขบัตรประจำตัวประชาชน',
                    //     labelStyle: TextStyle(
                    //         color: iBlackColor,
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 23),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: iBlueColor),
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: iBlueColor),
                    //     ),
                    //   ),
                    //   keyboardType: TextInputType.number,
                    //   maxLength: 13,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'กรุณาระบุเลขที่บัตรประจำตัวประชาชน';
                    //     }
                    //     if (!isNumeric(value)) {
                    //       return 'กรุณาระบุตัวเลขเท่านั้น';
                    //     }
                    //     if (value.length != 13) {
                    //       return 'กรุณาระบุให้ครบ 13 หลัก';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) {
                    //     _idCard = int.parse(value!);
                    //   },
                    //   initialValue: (context.read<PatientFormModel>().idCard ==
                    //           null)
                    //       ? idcard
                    //       : context.read<PatientFormModel>().idCard.toString(),
                    // ),
                  
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'ชื่อ นามสกุล',
                        
                        labelStyle: TextStyle(
                            color: iBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                      ), controller: _fullnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาระบุชื่อ';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _firstName = value;
                      },
                    //   initialValue:  
                              
                    //        a.toString()
                            
                    )
                    ,
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     labelText: 'นามสกุล',
                    //     labelStyle: TextStyle(
                    //         color: iBlackColor,
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 23),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: iBlueColor),
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: iBlueColor),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'กรุณาระบุนามสกุล';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) {
                    //     _lastName = value;
                    //   },
                    //    initialValue: (context.read<PatientFormModel>().lastName ==
                    //           null)
                    //       ? '${checkin[index].last_name}'
                    //       : context.read<PatientFormModel>().lastName
                    // ),
                    
                  //   TextFormField(
                  //     decoration: InputDecoration(
                  //       border: UnderlineInputBorder(),
                  //       labelText: 'เบอร์โทรศัพท์',                                                                          
                  //       hintText: 'กรอกเฉพาะตัวเลข 10 หลักติดกันไม่ต้องมีขีดขั้น',
                  //       labelStyle: TextStyle(
                  //           color: iBlackColor,
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 23),
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: iBlueColor),
                  //       ),
                  //       focusedBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: iBlueColor),
                  //       ),
                  //     ),
                  //     keyboardType: TextInputType.number,
                  //     maxLength: 10,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'กรุณาระบุเบอร์โทรศัพท์';
                  //       }
                  //       if (!isNumeric(value)) {
                  //         return 'กรุณาระบุตัวเลขเท่านั้น';
                  //       }
                  //       if (value.length != 10) {
                  //         return 'กรุณาระบุให้ครบ 10 หลัก';
                  //       }
                  //       return null;
                  //     },
                  //     onSaved: (value) {
                  //       _phone = (value);
                  //     },
                  //  initialValue: (context.read<PatientFormModel>().phone ==
                  //             null)
                  //         ? '${checkin[index].}'
                  //         : context.read<PatientFormModel>().phone
                  //   ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'สถานที่ตรวจ',
                        labelStyle: TextStyle(
                            color: iBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                      ), controller: _hospitalController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาระบุสถานที่';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _hospital = value;
                      },
                      //  initialValue: (context.read<PatientFormModel>().hospital ==
                      //         null)
                      //     ? ''
                      //     : context.read<PatientFormModel>().hospital
                    ),TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'วันที่',
                        labelStyle: TextStyle(
                            color: iBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: iBlueColor),
                        ),
                      ),controller: _checkdateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาระบุวันที่';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _checkindate = value;
                      },
                      //  initialValue: (context.read<PatientFormModel>().checkindate ==
                      //         null)
                      //     ? ''
                      //     : context.read<PatientFormModel>().checkindate
                    ),SizedBox(width: 20, height: 50),
                    Container(
                      // margin: EdgeInsets.only(top: 280),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        // BorderRadius: new BorderRadius.circular(30.0),
        
                        //height: 60,
                        // color: iBlueColor,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                             
                           List<BookingHospitelItem> listpatient = [];
                           
                            context.read<PatientFormModel>().idCard = _idCard;
                            context.read<PatientFormModel>().firstName =
                                _firstName;
                            context.read<PatientFormModel>().lastName = _lastName;
                            context.read<PatientFormModel>().hospital = _hospital;
                            context.read<PatientFormModel>().phone = _phone;
                            context.read<PatientFormModel>().checkindate = _checkindate;
                          context.read<PatientFormModel>().hospitel = 's';
                          context.read<PatientFormModel>().startdateadmit = 's';
                          context.read<PatientFormModel>().enddateadmit = 's';
                             if (context.read<PatientFormModelHospitel>().patientList != null) {
                            listpatient = context.read<PatientFormModelHospitel>().patientList;
                          print('///');
                          }
                          // listpatient = context.read<PatientFormModelHospitel>().patientList;
                            // print(_idCard);
                            // print(_firstName);
                            // print(_lastName);
                            // print(_hospital);
                            // print(_phone);
                            // print(_idCard);
                            // print(_checkindate);
        
        
                                //add to State
                             listpatient.add(BookingHospitelItem(
                               idCard: int.parse(_idcardController.text),
                              fullname:  _fullnameController.text,
                              phone:'',
                              checkindate:  DateTime.now().toString(),
                              hospital:  _hospitalController.text,
                              hospitel: '',
                              startdateadmit:DateTime.now().toString(),
                              enddateadmit:'',
                              status:'',
            
                              )
                          );
                          
                         // context.read<PatientFormModel>().patientList = Listpatient;
        
                                //add to firebase
                            var service = FirebaseServiceHospitel();
                              BookingHospitelController controller =
                                  BookingHospitelController(service);
                              controller.addBookingHospitel(new BookingHospitelItem(
                                  
                                  idCard:int.parse(_idcardController.text),
                                  fullname:_fullnameController.text,
                                  hospital:_hospitalController.text,
                                  checkindate: _checkdateController.text,
                                   hospitel: '',
                                   phone:'',
                                  startdateadmit: DateTime.now().toString(),
                                  enddateadmit: '',
                                  status: ''));
        
        
                                
                          //_showDialog(context);
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
                   // Text(qrString),
                   SizedBox(width: 20, height: 200),
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
                  ])),
        )),);
    
  }
}



  Future<void> scanQR() async {
    // try {
    //   FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancle", true, ScanMode.QR)
    //       .then((value) {
    //     setState(() {
    //       qrString = value;
    //       print(qrString);
    //       //qrString = "panita tharaphom";
    //     });
    //   });
    // } catch (e) {
    //   setState(() {});
    // }
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