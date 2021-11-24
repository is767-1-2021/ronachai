import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/hospitel_controller.dart';
import 'package:icovid/models/patient_form_model.dart';
import 'package:icovid/pages/hospital_home_page.dart';
import 'package:icovid/pages/hospitel_info_screen.dart';
import 'package:icovid/services/hospitel_service.dart';

import 'bottom_nav_page.dart';
import 'login_page.dart';

class PatientListPage extends StatefulWidget {
  var service = FirebaseServiceHospitelPatient();
  var controller;
  PatientListPage() {
    controller = HospitelController(service);
  }

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  List<BookingHospitel> _patientList = List.empty();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getHospitel();
  }

  void _getHospitel() async {
    var hospitellist = await widget.controller.fecthHospitelList();
    setState(() {
      _patientList = hospitellist;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _patientList.isEmpty ? 1 : _patientList.length,
          itemBuilder: (context, index) {
            if (_patientList.isEmpty) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 300),
                  child: 
                  Text('ไม่พบรายการผู้เข้ารับการตรวจ')));
            }

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: iWhiteColor, fontSize: 20),
                    ),
                  ),
                ),
                title: Text('${_patientList[index].fullname}'),
                subtitle: Text('${_patientList[index].startdateadmit}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HospitelDetail(items: _patientList[index]),
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
        backgroundColor: iBlueColor,
        title: Text('รายชื่อผู้เข้ารับการรักษา รพ.สนาม'),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavScreen()),
              );
            },
            icon: Icon(Icons.home_outlined),
          ),
           IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HostpitelInfoScreen()),
              );
            },
            icon: Icon(Icons.add_business),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
            },
          ),
        ],
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //     colors: [Colors.teal.shade600, Colors.amberAccent],
        //     begin: Alignment.bottomLeft,
        //     end: Alignment.bottomRight,
        //   )),
        // ),
      ),
      body: Center(
        child: body,
      ),
    );
  }
}

class HospitelDetail extends StatelessWidget {
  final BookingHospitel items;
  const HospitelDetail({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController _enddateadmitController =
        new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดผู้เข้ารับการรักษา'),
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
      body: SingleChildScrollView(
        child: Padding(
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
                  initialValue: '${items.fullname}',
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
                  initialValue: '${items.checkindate}',
                ),
      
                // TextFormField(
                //   decoration: InputDecoration(
                //     border: UnderlineInputBorder(),
                //     enabled: false,
                //     labelText: 'รหัสผ่าน',
                //     labelStyle: TextStyle(
                //         color: iBlackColor,
                //         fontWeight: FontWeight.w700,
                //         fontSize: 16),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: iBlueColor),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: iBlueColor),
                //     ),
                //   ),
                //   initialValue: '${user.password}',
                // ),
                Divider(),
                TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    enabled: false,
                    labelText: 'วันที่เข้ารับการรักษา',
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
                  initialValue: '${items.startdateadmit}',
                ),
                TextFormField(
                  controller: _enddateadmitController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    //enabled: false,
                    labelText: 'วันที่ออกการรักษา',
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
                  //initialValue: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString()
                ),
                Container(
                  margin: EdgeInsets.only(top: 350),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      print('submit');
                      var services = FirebaseServiceHospitelPatient();
                      var controllers = HospitelController(services).updateHospitel(
                        items.idcard,
                          '${items.checkindate}',
                          '${_enddateadmitController.text}'
                      );
      
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HospitalHomeScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: iBlueColor,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('บันทึก',
                        style: TextStyle(fontSize: 20, color: iWhiteColor)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

              // SizedBox(
              //   height: 20,
              // ),
              // Expanded(
              //   child: _foundPatient.length > 0
              //       ? ListView.builder(
              //           itemCount: _foundPatient.length,
              //           itemBuilder: (context, index) => Card(
              //             key: ValueKey(_foundPatient[index]["id"]),
              //             color: Colors.greenAccent.shade100,
              //             elevation: 4,
              //             margin: EdgeInsets.symmetric(vertical: 10),
              //             child: ListTile(
              //               leading: Text(
              //                 _foundPatient[index]["id"].toString(),
              //                 style: TextStyle(
              //                     fontSize: 27, color: Colors.teal.shade600),
              //               ),
              //               title: Text(
              //                 _foundPatient[index]['name'],
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   color: Colors.teal.shade600,
              //                 ),
              //               ),
              //               subtitle: Text(
              //                 '${_foundPatient[index]["age"].toString()} years old',
              //                 style:
              //                     TextStyle(fontSize: 15, color: Colors.grey),
              //               ),
              //               onTap: () => {
              //                 getItemAndNavigate(
              //                     //_foundPatient.toString(), context)
              //                     _foundPatient[index]['name'],
              //                     context)
              //               },

              //               /* onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => StatusForm(),
              //                   ),
              //                 );
              //               },*/
              //             ),
              //           ),
              //         )
              //       : Text(
              //           'No results found',
              //           style: TextStyle(fontSize: 24),
              //         ),
              // ),
           