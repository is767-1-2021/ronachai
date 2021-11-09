
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/patient_class_hospitel.dart';
import 'package:icovid/models/patient_form_model_hospitel.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class PatientListPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
    List<PatientHospitel> _patientList = [];
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iBlueColor,
        title: Text('รายชื่อผู้เข้ารับการรักษา Hospitel'),
        // centerTitle: true,
        automaticallyImplyLeading: false,
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
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //     colors: [Colors.teal.shade600, Colors.amberAccent],
        //     begin: Alignment.bottomLeft,
        //     end: Alignment.bottomRight,
        //   )),
        // ),
      ),
      body: PatientSearch(),
    );
  }
}


class PatientSearch extends StatefulWidget {
  @override
  _PatientSearchState createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {

  // getItemAndNavigate(String item, BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => StatusForm(itemHolder: item)));
  // }

  // List<Map<String, dynamic>> _foundPatient = [];

  // @override
  // initState() {
  //   _foundPatient = _allPatient;
  //   super.initState();
  // }

  // void _runFilter(String enteredKeyword) {
  //   List<Map<String, dynamic>> results = [];

  //   if (enteredKeyword.isEmpty) {
  //     results = _allPatient;
  //   } else {
  //     results = _allPatient
  //         .where((user) =>
  //             user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }

  //   setState(() {
  //     _foundPatient = results;
  //   });
  // }

 
  @override
  Widget build(BuildContext context) {
    List<PatientHospitel> _patientList = [];
    if (context.read<PatientFormModelHospitel>().patientList != null) {
      _patientList = context.read<PatientFormModelHospitel>().patientList;
    }
    return Scaffold(
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(10),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: 20,
      //         ),
      //         TextField(
      //           onChanged: (value) => _runFilter(value),
      //           decoration: InputDecoration(
      //               hintText: "Enter patient name",
      //               hintStyle: TextStyle(color: Colors.amber),
      //               labelText: 'Search Patient',
      //               floatingLabelBehavior: FloatingLabelBehavior.always,
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(20),
      //               ),
      //               suffixIcon: Icon(Icons.search)),
      //         ),

               body: 
               ListView.builder(
        itemCount: _patientList.length,
        itemBuilder: (context, int index) {
          //User data = provider.users[index];
          return Dismissible(
            key: ValueKey(_patientList[index]),
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                //UserProvider().RemoveUserList(_userList[index]);
                _patientList.removeAt(index);
              });

              // Then show a snackbar.
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${_patientList[index].lastName} ถูกลบ')));
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Icon(Icons.person),
                  ),
                ),
                title: Text('${_patientList[index].firstName}'' ''${_patientList[index].lastName}'),
                subtitle: Text('${_patientList[index].dateappointment}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientDetail(Patients: _patientList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class PatientDetail extends StatelessWidget {
  final PatientHospitel Patients;
  const PatientDetail({Key? key, required this.Patients}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              initialValue: '${Patients.firstName}'  '${Patients.lastName}',
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
              initialValue: '${Patients.dateappointment}',
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
              initialValue: '${Patients.phone}',
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
              initialValue: '${Patients.dateappointment}',
            ), 
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
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
            ),ElevatedButton(
                            
                            onPressed: () {
                              // if (formKey.currentState!.validate()) {
                              //   formKey.currentState!.save();

                              //   List<Patient> Listpatient = [];
                              //   print('${form.firstName}');
                              //   print('${form.lastName}');
                              //   print('${form.phone}');

                              //   if (context
                              //           .read<PatientFormModel>()
                              //           .patientList !=
                              //       null) {
                              //     print('||||');
                              //     Listpatient = context
                              //         .read<PatientFormModel>()
                              //         .patientList;
                              //   }
                              //   Listpatient.add(Patient(
                              //       idCard: 11,
                              //       firstName: '${form.firstName}',
                              //       lastName: '${form.lastName}',
                              //       phone: '${form.phone}',
                              //       dateappointment:
                              //           '${form.dateappointment}'));

                              //   context.read<PatientFormModel>().patientList =
                              //       Listpatient;
                              //   // _showDialog(context);
                              
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientListPage()));
                        }, style: ElevatedButton.styleFrom(
                        primary: iBlueColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('บันทึก',
                          style: TextStyle(fontSize: 20, color: iWhiteColor)),
                    )
          ],
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
           