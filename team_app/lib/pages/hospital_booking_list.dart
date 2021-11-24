
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_hospitel_controller.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/models/patient_form_model_hospitel.dart';
import 'package:icovid/services/booking_hospitel_service.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'result_page.dart';


class HospitalBookingsList extends StatefulWidget {
var service = FirebaseServiceHospitel();
  var controller;
  HospitalBookingsList() {
    controller = BookingHospitelController(service);
  }
  @override
  _HospitalBookingsListState createState() => _HospitalBookingsListState();
}

class _HospitalBookingsListState extends State<HospitalBookingsList> {
List<BookingHospitelList> checkin = List.empty();
  bool isLoading = false;

@override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
        _getCheckin();
  }

  void _getCheckin() async {
    var checkinlist = await widget.controller.fecthCheckinList();
    setState(() {
      checkin = checkinlist;
    });
  }


Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
        itemCount: checkin.isEmpty ? 1 : checkin.length,
        itemBuilder: (context,  index) {
           if (checkin.isEmpty) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 300),
                  child: Text('ไม่พบรายการผู้เข้ารับการตรวจ')));
            }
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
              title: Text('${checkin[index].fullName}'),
              subtitle: Text('${checkin[index].checkDate}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  PatientDetail(items: checkin[index]),
                  ),
                );
              },
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
  
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
      ),
    );
  }
}

class PatientDetail extends StatelessWidget {
  final BookingHospitelList items;
  const PatientDetail({Key? key, required this.items}) : super(key: key);

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
        padding: const EdgeInsets.all(20.0), 
       
            //key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'เลขบัตรประชาชน',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 23),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.idCardNumber}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ชื่อ-นามสกุล',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 23),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.fullName}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'วันที่เข้ารับการตรวจเชื้อ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 23),
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
                labelText: 'โรงพยาบาลที่ตรวจเชื้อ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 23),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.hospitalName}',
            ),
            
            SizedBox(
  width: 20.0,
  height: 30.0,
  
),
                        Container(
                    // margin: EdgeInsets.only(top: 280),
                    width: MediaQuery.of(context).size.width,height: 60,
                    child: ElevatedButton(
                      // BorderRadius: new BorderRadius.circular(30.0),

                      //height: 60,
                      // color: iBlueColor,
                      onPressed: () { 
        

                          //รับค่าจาก ProfileModel -> TextFormField -> BookingModel
                        // context.read<PatientFormModelHospitel>().idCard = items.idcard;
                          context.read<PatientFormModelHospitel>().firstName =
                              '${items.fullName}';
                              // context.read<PatientFormModelHospitel>().lastName =
                              // '${items.fullname}';
                          context.read<PatientFormModelHospitel>().hospital = '${items.hospitalName}';
                         // context.read<PatientFormModelHospitel>().phone = '${items.phone}';
                          context.read<PatientFormModelHospitel>().checkindate = '${items.checkDate}';
                          context.read<PatientFormModelHospitel>().idCard = int.parse(items.idCardNumber);
                          print('items.idCardNumber:${items.idCardNumber}');


                           List<PatientFormModelHospitel> Listpatient = [];
                           if (context.read<PatientFormModelHospitel>().patientList != null) {
                          
                          Listpatient = context.read<PatientFormModelHospitel>().patientList;
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
    );
  }
}

class BookingHospitelItem {
  final int idCard;
  final String fullname;
  final String hospitel;
  final String startdateadmit;
  final String enddateadmit;
  final String status;
  final String hospital;
  final String phone;
final String checkindate;

  const BookingHospitelItem({
    Key? key,
    required this.idCard,
    required this.fullname,
    required this.hospitel,
    required this.startdateadmit,
    required this.enddateadmit,
    required this.status,
     required this.hospital,
     required this.checkindate,
     required this.phone,
  });

  add(Map<String, String> map) {}
}