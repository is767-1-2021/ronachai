import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_hospitel_controller.dart';
import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/models/hospitel_info_class.dart';
import 'package:icovid/models/patient_class.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/models/patient_form_model_hospitel.dart';
import 'package:icovid/services/booking_hospitel_service.dart';
import 'package:provider/provider.dart';

import 'hospital_home_page.dart';

class Result_Page extends StatefulWidget {
  @override
  _Result_PageState createState() => _Result_PageState();
}

class _Result_PageState extends State<Result_Page> {
  final formKey = GlobalKey<FormState>();
  List<BHospitel> hospitelList = List.empty();
  BHospitel? _selectHospitel;
  String hopitel = " ";
  String hopitelid = "กรุณาเลือก";
  List hopitelist = [
    'กรุณาเลือก',
    'โรงแรมธรี สุขุวิท',
    'โรงแรมแอนดา',
    'โรงแรมไฮ โฮเท็ล'
  ];
  var service = FirebaseServiceHospitel();
  var controller;
  _Result_PageState() {
    controller = BookingHospitelController(service);
  }

  @override
  void initState() {
    super.initState();
    _getHospitelList();
  }

  void _getHospitelList() async {
    hospitelList = await controller.fecthHospitelList();
    print('hos_id:${hospitelList[0].hospitel_number}');
  }

  void getDropDownItem() {
    setState(() {
      hopitelid = hopitel;
      // myleave.leaveid = leaveid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'บันทึกผลการตรวจ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: iWhiteColor),
            ),
            backgroundColor: iBlueColor),
        body: Consumer<PatientFormModel>(builder: (context, form, child) {
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                  child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                    // Consumer<FirstFormModel>(
                    // builder: (context, form, child) {
                    //   return Text('${form.firstName} ${form.lastName} ${form.age}');
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("ชื่อ-นามสกุล : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Consumer<PatientFormModelHospitel>(
                                  builder: (context, form, child) {
                                    return Text(
                                      '${form.firstName}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    );
                                  },
                                ),
                              ])
                            ],
                          ),
                        ]),
                  )),
                  // Container(
                  //     child: Padding(
                  //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: <Widget>[
                  //         Column(
                  //           children: <Widget>[
                  //             Text("เบอร์โทรศัพท์ : ",
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.w700)),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: <Widget>[
                  //             Row(children: <Widget>[
                  //               Consumer<PatientFormModelHospitel>(
                  //                 builder: (context, form, child) {
                  //                   return Text(
                  //                     '${form.phone} ',
                  //                     style: TextStyle(
                  //                         fontSize: 18, color: Colors.black),
                  //                   );
                  //                 },
                  //               ),
                  //             ])
                  //           ],
                  //         ),
                  //       ]),
                  // )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("โรงพยาบาลที่เข้ารับการตรวจ : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          // Column(
                          //   children: <Widget>[
                          //     Row(children: <Widget>[
                          //       //  SizedBox(
                          //       // height: 50,
                          //       // width: 250,
                          //       Consumer<PatientFormModel>(
                          //         builder: (context, form, child) {
                          //           return Text(
                          //             '${form.hospital}',
                          //             style: TextStyle(
                          //                 fontSize: 18, color: Colors.black),
                          //           );
                          //         },
                          //       ),
                          //     ])
                          //   ],
                          // ),
                        ]),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Column(
                          //   children: <Widget>[
                          //     Text("โรงพยาบาลที่เข้ารับการตรวจ : ",
                          //         style: TextStyle(
                          //             fontSize: 18, color: Colors.black)),
                          //   ],
                          // ),
                          Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                //  SizedBox(
                                // height: 50,
                                // width: 250,
                                Consumer<PatientFormModelHospitel>(
                                  builder: (context, form, child) {
                                    return Text(
                                      '${form.hospital}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    );
                                  },
                                ),
                              ])
                            ],
                          ),
                        ]),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("วันที่เข้ารับการตรวจ : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                //  SizedBox(
                                // height: 50,
                                // width: 250,
                                Consumer<PatientFormModelHospitel>(
                                  builder: (context, form, child) {
                                    //String dateappointment = DateFormat('dd-MM-yyyy').format(form.dateappointment);
                                    return Text(
                                      '${form.checkindate}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    );
                                  },
                                ),
                              ])
                            ],
                          ),
                        ]),
                  )),

                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text("Hospitel ที่ต้องการรักษา : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ])),
                  ),
                  Container(
                    child: Column(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //  SizedBox(
                          // height: 50,
                          // width: 250,
                          DropdownButton<String>(
                            isExpanded: true,
                              value: hopitel,
                              items: <String>[
                                ' ',
                                'โรงแรมธรีสุขุวิท',
                                'โรงแรมแอนดา',
                                'โรงแรมไฮโฮเท็ล'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  hopitel = newValue!;

                                  // myleave.leaveid = leavetype;
                                });
                              })
                          // DropdownButton<BHospitel>(
                          //     isExpanded: true,
                          //     value: _selectHospitel,
                          //     style: TextStyle(color: iBlueColor),
                          //     underline: Container(
                          //       height: 2,
                          //       color: iBlueColor,
                          //     ),
                          //     onChanged: (newValue) {
                          //       setState(() {
                          //         _selectHospitel = newValue!;
                          //         hopitel = newValue.hospitel_name;
                          //         hopitelid = newValue.hospitel_number.toString();
                          //       });
                          //     },
                          //     items: hospitelList
                          //     .map<DropdownMenuItem<BHospitel>>((BHospitel value) {
                          //       return DropdownMenuItem<BHospitel>(
                          //         value: value,
                          //         child: Text(value.hospitel_name),
                          //       );
                          //     }).toList(),
                          // ),
                        ],
                      ),
                    ]),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            List<Patient> Listpatient = [];
                            // print('${form.firstName}');
                            // print('${form.lastName}');
                            // print('${form.phone}');

                            if (context
                                    .read<PatientFormModelHospitel>()
                                    .patientList !=
                                null) {
                              print('||||');
                              Listpatient = context
                                  .read<PatientFormModelHospitel>()
                                  .patientList;
                            }
                            print('idcard:${form.idCard}');
                            //update hospitel
                            controller.updateHospitel(
                                form.idCard, '${form.checkindate}', hopitel);

                            controller.updateResultPatient(
                                form.idCard, //"แก้ตรงนี้ยยยยยยยยยยยยยยย"
                                //  '${form.checkindate}');
                                // 1111111111111,
                                '${form.checkindate}',
                                'ติดเชื้อ');

                            Listpatient.add(Patient(
                                idCard: form.idCard,
                                firstName: '${form.firstName}',
                                lastName: '${form.lastName}',
                                phone: '${form.phone}',
                                checkindate: '${form.checkindate}'));

                            // context
                            //     .read<PatientFormModelHospitel>()
                            //     .patientList = Listpatient;

                          }
                          _showDialog(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HospitalHomeScreen()));
                          const SnackBar(content: Text('บันทึกผลเรียบร้อย'));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: iBlueColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text('ติดเชื้อ',
                            style: TextStyle(fontSize: 20, color: iWhiteColor)),
                      )),

                  SizedBox(
                    width: 20.0,
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                          controller.updateResultPatient(
                                     form.idCard,  //"แก้ตรงนี้ยยยยยยยยยยยยยยย"
                                  //  '${form.checkindate}');
                                 // 1111111111111,
                                 '${form.checkindate}','ไม่ติดเชื้อ');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HospitalHomeScreen()));
                        const SnackBar(content: Text('บันทึกผลเรียบร้อย'));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: iBlueColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('ไม่ติดเชื้อ',
                          style: TextStyle(fontSize: 20, color: iWhiteColor)),
                    ),
                  ),
                ])),
              )));
        }));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('สำเร็จ'),
        content: Text('บันทึกผลเรียบร้อย'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HospitalHomeScreen()));
              },
              child: Text('ตกลง'))
        ],
      );
    },
  );
}