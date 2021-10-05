
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/patient_class.dart';
import 'package:icovid/models/patient_class_hospitel.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/models/patient_form_model_hospitel.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'result_page.dart';


class HospitalBookingsList extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    List<Patient> _patientList = [];
    if (context.read<PatientFormModel>().patientList!= null) {
      _patientList = context.read<PatientFormModel>().patientList;
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
        body: ListView.builder(
        itemCount: _patientList.length,
        itemBuilder: (context, int index) {
          //User data = provider.users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                  child: Text('${index+1}',
                    style: TextStyle(color: iWhiteColor,fontSize: 20),
                  ),
                ),
              ),
              title: Text('${_patientList[index].firstName}'),
              subtitle: Text('${_patientList[index].lastName}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  PatientDetail(Patients: _patientList[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PatientDetail extends StatefulWidget {
  
  final Patient Patients;
  
  const PatientDetail({Key? key, required this.Patients}) : super(key: key);

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดผู้เข้ารับการตรวจ'),
        backgroundColor: iBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LogInScreen()),
              // );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: Form(
            key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ชื่อ-นามสกุล',
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
              initialValue: '${widget.Patients.firstName}'  '${widget.Patients.lastName}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'วันที่เข้ารับการตรวจเชื้อ',
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
              initialValue: '${widget.Patients.dateappointment}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'เบอร์โทรศัพท์ผู้ป่วย',
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
              initialValue: '${widget.Patients.phone}',
            ),
            
            Divider(),
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
              initialValue: '${widget.Patients.dateappointment}',
            ),
            Container(
                    // margin: EdgeInsets.only(top: 280),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      // BorderRadius: new BorderRadius.circular(30.0),

                      //height: 60,
                      // color: iBlueColor,
                      onPressed: () { 
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          //รับค่าจาก ProfileModel -> TextFormField -> BookingModel
                         // context.read<PatientFormModel>().idCard = _idCard;
                          context.read<PatientFormModelHospitel>().firstName =
                             '${widget.Patients.firstName}';
                          context.read<PatientFormModelHospitel>().lastName = '${widget.Patients.lastName}';
                          context.read<PatientFormModelHospitel>().hospital = '${widget.Patients.hospital}';
                          context.read<PatientFormModelHospitel>().phone = '${widget.Patients.phone}';
                          context.read<PatientFormModelHospitel>().dateappointment = '${widget.Patients.dateappointment}';

                           List<PatientHospitel> Listpatient = [];
                           if (context.read<PatientFormModelHospitel>().patientList != null) {
                          
                          Listpatient = context.read<PatientFormModelHospitel>().patientList;
                        }
                           Listpatient.add(PatientHospitel(
                             idCard: 11,
                            firstName:  '${widget.Patients.firstName}',
                            lastName: '${widget.Patients.lastName}',
                            phone: '${widget.Patients.phone}',
                            dateappointment: '${widget.Patients.dateappointment}'
                        
                            
                            )
                        );
                        
                        context.read<PatientFormModelHospitel>().patientList = Listpatient;
                      
                      }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Result_Page()));
                        }
                      ,
                      style: ElevatedButton.styleFrom(
                        primary: iBlueColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('บันทึกผลการตรวจ',
                          style: TextStyle(fontSize: 20, color: iWhiteColor)),
                    ),
                  )
          ],
        ),
      ),
    ));
  }
}