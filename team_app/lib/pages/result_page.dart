import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/patient_class.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:provider/provider.dart';

import 'hospital_home_page.dart';
import 'patient_list_page.dart';

class Result_Page extends StatefulWidget {
  const Result_Page({Key? key}) : super(key: key);

  @override
  _Result_PageState createState() => _Result_PageState();
}

class _Result_PageState extends State<Result_Page> {
  final formKey = GlobalKey<FormState>();
  String leavetype = " ";
  String leaveid = "";
  List leavelist = ['โรงแรมธรี สุขุวิท', 'โรงแรมแอนดา', 'โรงแรมไฮ โฮเท็ล'];

  void getDropDownItem() {
    setState(() {
      leaveid = leavetype;
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
          return Card(
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
                                    fontSize: 18, color: Colors.black)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Consumer<PatientFormModel>(
                                builder: (context, form, child) {
                                  return Text(
                                    '${form.firstName} ${form.lastName} ',
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
                            Text("เบอร์โทรศัพท์ : ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Consumer<PatientFormModel>(
                                builder: (context, form, child) {
                                  return Text(
                                    '${form.phone} ',
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
                            Text("โรงพยาบาลที่เข้ารับการตรวจ : ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
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
                              Consumer<PatientFormModel>(
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
                                    fontSize: 18, color: Colors.black)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              //  SizedBox(
                              // height: 50,
                              // width: 250,
                              Consumer<PatientFormModel>(
                                builder: (context, form, child) {
                                  //String dateappointment = DateFormat('dd-MM-yyyy').format(form.dateappointment);
                                  return Text(
                                    '${form.dateappointment}',
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
                                        fontSize: 18, color: Colors.black)),
                              ],
                            ),
                            Column(children: <Widget>[
                              Row(
                                children: <Widget>[
                                  //  SizedBox(
                                  // height: 50,
                                  // width: 250,
                                  DropdownButton<String>(
                                      value: leavetype,
                                      items: <String>[
                                        ' ',
                                        'โรงแรมธรี สุขุวิท',
                                        'โรงแรมแอนดา',
                                        'โรงแรมไฮ โฮเท็ล'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          leavetype = newValue!;

                                          // myleave.leaveid = leavetype;
                                        });
                                      })
                                ],
                              ),
                            ]),
                          ])),
                ),

                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            List<Patient> Listpatient = [];
                            print('${form.firstName}');
                            print('${form.lastName}');
                            print('${form.phone}');

                            if (context.read<PatientFormModel>().patientList !=
                                null) {
                              print('||||');
                              Listpatient =
                                  context.read<PatientFormModel>().patientList;
                            }
                            Listpatient.add(Patient(
                                idCard: 11,
                                firstName: '${form.firstName}',
                                lastName: '${form.lastName}',
                                phone: '${form.phone}',
                                dateappointment: '${form.dateappointment}'));

                            context.read<PatientFormModel>().patientList =
                                Listpatient;
                            // _showDialog(context);
                          }
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
                      )
                    ])),

                // style: ElevatedButton.styleFrom(primary: Colors.green),
                // child: Text('เพิ่ม')

                // SizedBox(width: 20, height: 50),
                ElevatedButton(
                  onPressed: () {
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
                )
              ]),
            ),
          ));
        }));
  }
}

// void _showDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('สำเร็จ'),
//         content: Text('คุณได้เพิ่มผู้ใช้งานเรียบร้อยแล้ว'),
//         actions: [
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PatientListPage()));
//               },
//               child: Text('ตกลง'))
//         ],
//       );
//     },
//   );
// }
