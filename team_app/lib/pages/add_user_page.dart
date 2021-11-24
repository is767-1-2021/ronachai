import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_controller.dart';
import 'package:icovid/controllers/user_controller.dart';
import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/models/user_class_model.dart';

import 'package:icovid/models/user_provider.dart';
import 'package:icovid/services/booking_service.dart';
import 'package:icovid/services/user_service.dart';
import 'package:provider/provider.dart';
import 'list_user_page.dart';
import 'login_page.dart';

class AddFormPage extends StatefulWidget {
  @override
  _AddFormPageState createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final formKey = GlobalKey<FormState>();
  List<BHospital> hospitalList = List.empty();
 var service = BookingServices();
 var controller;
  _AddFormPageState() {
    controller = BookingController(service);
  }

  UserRole? _selectUserRole;
  BHospital? _selectHospitel;
  String _email="";
  String _firstName="";
  String _lastName="";
  String _position="";
  String _password="";
  int _roleId = 0;
  String _roleName = "";
  int _hospitalId = 0;
  String _hospitalName="";

  // final usernameController = TextEditingController();

  // final nameController = TextEditingController();

  // final positionController = TextEditingController();

  // final passwordController = TextEditingController();

  List<UserRole> roleList = [
    UserRole(
      roleName: 'ผู้ดูแลระบบ',
      roleId: 1,
    ),
    //UserRole(roleName: 'ผู้ใช้งานทั่วไป', roleId: 2),
    UserRole(roleName: 'โรงพยาบาล', roleId: 3),
    UserRole(roleName: 'สถานพยาบาลผู้ป่วยเฉพาะกิจ', roleId: 4),
    //UserRole(roleName: 'ผู้ดูแลระบบของโรงพยาบาล', roleId: 5),
    //UserRole(roleName: 'ผู้ดูแลระบบของสถานพยาบาลผู้ป่วยเฉพาะกิจ', roleId: 6),
  ];

  @override
  void initState() {
    _getHospitalList();
  }

  void _getHospitalList() async {
    hospitalList = await controller.fecthHospitalList();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<UserRole>> items = roleList.map((item) {
      return DropdownMenuItem<UserRole>(
        child: Text(item.roleName),
        value: item,
      );
    }).toList();
    // List<DropdownMenuItem<Hospital>> hospitalItems =
    //     hostpitalListData.map((item) {
    //   return DropdownMenuItem<Hospital>(
    //     child: Text(item.hospitalName!),
    //     value: item,
    //   );
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มผู้ใช้งาน'),
        backgroundColor: iBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'อีเมล์',
                    //hintText: 'you@domain.com',
                    icon: Icon(Icons.email_sharp)),
                //keyboardType: TextInputType.emailAddress,
                //controller: usernameController,
                validator: (username) {
                  if ((username == null || username.isEmpty)) {
                    return 'กรุณากรอกอีเมล์';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ชื่อ',
                    icon: Icon(Icons.assignment)),
                //controller: nameController,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'กรุณากรอกชื่อ';
                  }

                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'นามสกุล',
                    icon: Icon(Icons.assignment)),
                //controller: nameController,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'กรุณากรอกนามสกุล';
                  }

                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ตำแหน่ง',
                    icon: Icon(Icons.location_city_sharp)),
                //controller: positionController,
                validator: (position) {
                  if (position == null || position.isEmpty) {
                    return 'กรุณากรอกตำแหน่ง';
                  }
                  return null;
                },
                onSaved: (value) {
                  _position = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'รหัสผ่าน',
                    icon: Icon(Icons.vpn_key)),
                //controller: passwordController,
                validator: (password) {
                  if (password!.length < 6) {
                    return 'กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร';
                  }

                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Divider(
                      height: 3,
                    ),
                    Text(
                      'ประเภทผู้ใช้งาน',
                      style: TextStyle(
                          color: iBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton<UserRole>(
                    isExpanded: true,
                    value: _selectUserRole,
                    style: TextStyle(color: iBlueColor),
                    underline: Container(
                      height: 2,
                      color: iBlueColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectUserRole = newValue;
                        _roleId = newValue!.roleId;
                        _roleName = newValue.roleName;
                      });
                    },
                    items: items),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Divider(
                      height: 3,
                    ),
                    Text(
                      'สังกัดโรงพยาบาล/สถานพยาบาลผู้ป่วยเฉพาะกิจ',
                      style: TextStyle(
                          color: iBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton<BHospital>(
                    isExpanded: true,
                    value: _selectHospitel,
                    style: TextStyle(color: iBlueColor),
                    underline: Container(
                      height: 2,
                      color: iBlueColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectHospitel = newValue;
                        _hospitalId = newValue!.hospital_number;
                        _hospitalName = newValue.hospital_name;
                      });
                    },
                    items: hospitalList
                    .map<DropdownMenuItem<BHospital>>((BHospital value) {
                  return DropdownMenuItem<BHospital>(
                    value: value,
                    child: Text(value.hospital_name),
                  );
                }).toList(),
                    ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          

                          if (_roleId == 0 || _roleName == null) {
                            _showDialog(context, 'กรุณาเลือกประเภทผู้ใช้งาน');
                          } else {
                            //Add User to List
                            List<User> listUser = [];
                            if (context.read<UserProvider>().userList != null) {
                              listUser = context.read<UserProvider>().userList;
                            }

                            //Add to State
                            //listUser.add(User(_firstName!, _lastName!, _email!, _password!, _position!, _roleId!, _roleName!, _hospitalId!, _hospitalName!));

                            //   listUser.add(User());
                            //       


                            //add to firebase
                                          var service = UserServices();
                                          UserController controller = UserController(service);
                                          if(_roleId == null){
                                              _roleId = 0;
                                          }
                                          controller.addUser(new User(_firstName, _lastName, _email, _password, _position, _roleId, _roleName, _hospitalId, _hospitalName));

                            //context.read<UserProvider>().userList = listUser;
                            _showDialog(
                                context, 'คุณได้เพิ่มผู้ใช้งานเรียบร้อยแล้ว');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: Text('เพิ่ม'),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   style: ElevatedButton.styleFrom(primary: Colors.red),
                    //   child: Text('ยกเลิก'),
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.reset();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Text('ล้างข้อมูล'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('แจ้งเตือน'),
        content: Text(text),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListUser()));
              },
              child: Text('ตกลง'))
        ],
      );
    },
  );
}

class UserRole {
  String roleName;
  int roleId;

  UserRole({required this.roleName, required this.roleId});
}