import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:icovid/models/profile_model.dart';
import 'package:icovid/pages/booking_step2_page.dart';
import 'package:provider/provider.dart';

class BookingStep1Screen extends StatelessWidget {
  const BookingStep1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STEP 1 : ข้อมูลทั่วไป',
          style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.w700, 
              color: iWhiteColor
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: Step1Custom(),
    );
  }
}

class Step1Custom extends StatefulWidget {
  const Step1Custom({Key? key}) : super(key: key);

  @override
  _LogInCustomState createState() => _LogInCustomState();
}

class _LogInCustomState extends State<Step1Custom> {
  final _formkey = GlobalKey<FormState>();
  int? _id_card;
  String? _first_name;
  String? _last_name;
  String? _tel;

  @override
  Widget build(BuildContext context) {
    //รอรับค่ามาจาก Login
    context.read<ProfileModel>().id_card = 1234567890123;
    context.read<ProfileModel>().first_name = "รณชัย";
    context.read<ProfileModel>().last_name = "จำศิล";
    context.read<ProfileModel>().tel = "0623456789";

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
                _id_card = int.parse(value!);
              },
              initialValue: (context.read<ProfileModel>().id_card == null)
                  ? ''
                  : context.read<ProfileModel>().id_card.toString(),
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
              initialValue: context.read<ProfileModel>().first_name,
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
              initialValue: context.read<ProfileModel>().last_name,
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
                _tel = value;
              },
              initialValue: context.read<ProfileModel>().tel,
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
                            builder: (context) => BookingStep2Screen()
                        )
                      );
                  }
                },
                child: Text(
                  'ถัดไป',
                  style: TextStyle(
                    fontSize: 20, 
                    color: iWhiteColor)
                  ),
              ),
            ),
          ],
        ),
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
