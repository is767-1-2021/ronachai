import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/auth_controller.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/user_profile_provider.dart';
import 'package:icovid/models/user_provider.dart';
import 'package:icovid/pages/booking_step2_page.dart';
import 'package:icovid/services/auth_service.dart';
import 'package:provider/provider.dart';


class BookingStep1Screen extends StatefulWidget {
  var service = AuthService();
  var controller;
  BookingStep1Screen() {
    controller = AuthController(service);
  }

  @override
  _LogInCustomState createState() => _LogInCustomState();
}

class _LogInCustomState extends State<BookingStep1Screen> {
  final _formkey = GlobalKey<FormState>();
  int? _id_card;
  String? _first_name;
  String? _last_name;
  String? _tel;
   
  UserProfileProvider _profile = UserProfileProvider();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.controller.onSyncAuth.listen((bool syncState) => setState(() => isLoading = syncState));
    _loadProfile();
  }

  void _loadProfile() async{
    var newProfile = await widget.controller.GetUserInfo(auth.currentUser!.email);
    setState(()  {
      _profile = newProfile;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      :Form(
      key: _formkey,
      child: Consumer<UserProvider>(builder: (context, form, child) {
        return Padding(
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
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
                  _id_card = int.parse(value!);
                },
                initialValue: _profile.cid//context.read<UserProfileProvider>().cid 
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
                  _first_name = value;
                },
                initialValue: _profile.firstName//context.read<UserProvider>().first_name 
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
                  _last_name = value;
                },
                initialValue: _profile.lastName//context.read<UserProfileProvider>().lastName 
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
                  _tel = value;
                },
                initialValue: _profile.tel//ontext.read<UserProfileProvider>().tel 
              ),
              Container(
                margin: EdgeInsets.only(top: 280),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  height: 60,
                  color: iBlueColor,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      //รับค่าจาก ProfileModel -> TextFormField -> BookingModel
                      context.read<BookingModel>().id_card = _id_card;
                      context.read<BookingModel>().first_name = _first_name;
                      context.read<BookingModel>().last_name = _last_name;
                      context.read<BookingModel>().tel = _tel;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingStep2Screen()));
                    }
                  },
                  child: Text('ถัดไป',
                      style: TextStyle(fontSize: 20, color: iWhiteColor)),
                ),
              ),
            ],
          ),
        );
      }),
    );

  @override
  Widget build(BuildContext context) {
    //รอรับค่ามาจาก Login Provider --> ProfileModel ซึ่งข้อมูลไม่ต้องกรอกใหม่เพื่ออำนวยความสะดวกให้แก่ผู้ใช้งาน
    // context.read<UserProvider>().id_card = 1234567890123;
    //context.read<UserProvider>().first_name = _profile.firstName;
    // context.read<UserProvider>().last_name = "จำศิล";
    // context.read<UserProvider>().tel = "0623456789";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STEP 1 : ข้อมูลทั่วไป',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
        ),
        backgroundColor: iBlueColor,
      ),
      body: Center(
        child: SingleChildScrollView(child: body),
      ),
    );
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
