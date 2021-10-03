import 'package:flutter/material.dart';
import 'package:midterm_app/constants/color_constant.dart';
import 'package:midterm_app/constants/font_sonstant.dart';
import 'package:midterm_app/models/booking_list_model.dart';
import 'package:midterm_app/models/booking_model.dart';
import 'package:midterm_app/pages/rbooking_list_page.dart';
import 'package:provider/provider.dart';

import 'booking_summary.dart';

class BookingStep2Screen extends StatelessWidget {
  const BookingStep2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STEP 2 : ข้อมูลการรับบริการ',
          style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: Step2Custom(),
    );
  }
}

class Step2Custom extends StatefulWidget {
  const Step2Custom({Key? key}) : super(key: key);

  @override
  _LogInCustomState createState() => _LogInCustomState();
}

class _LogInCustomState extends State<Step2Custom> {
  final _formkey = GlobalKey<FormState>();
  int? _avaliableQueue;
  int? _allQueue;
  int _queue_number = 0;
  var _txtDate = TextEditingController();
  String? _dateSelected;
  Hospitel? _selectHospitel;
  List<Hospitel> hostpitelList = [
    Hospitel(name: 'โรงพยาบาลเกษมราษฏร์ประชาชื่น',avaliableQueue: 10,allQueue: 100),
    Hospitel(name: 'โรงพยาบาลบำรุงราษฎร์', avaliableQueue: 20, allQueue: 99),
    Hospitel(name: 'โรงพยาบาลวิภาวดี', avaliableQueue: 30, allQueue: 98),
    Hospitel(name: 'โรงพยาบาลกรุงเทพ', avaliableQueue: 40, allQueue: 97),
    Hospitel(name: 'โรงพยาบาลธนบุรี', avaliableQueue: 50, allQueue: 96),
  ];

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  Future<Null> selectDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030),
        helpText: 'กรุณาเลือกวันที่เข้ารับการตรวจ',
        cancelText: 'ยกเลิก',
        confirmText: 'ตกลง',
        fieldLabelText: 'วันที่เข้ารับการตรวจ',
        fieldHintText: 'วว/ดด/ปปปป(คศ.)');
    if (datePicked != null && datePicked != date) {
      setState(() {
        date = datePicked;
        _dateSelected = '${date.day}/${date.month}/${date.year}';
        _txtDate.text = '${date.day}/${date.month}/${date.year}';
        context.read<BookingModel>().booking_date ='${date.day}/${date.month}/${date.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _queue_number = context.read<BookingModel>().queue_number;
    List<DropdownMenuItem<Hospitel>> items = hostpitelList.map((item) {
      return DropdownMenuItem<Hospitel>(
        child: Text(item.name),
        value: item,
      );
    }).toList();

    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          child: Text(_selectHospitel!.name),
          value: _selectHospitel,
        )
      ];
    }

    return Form(
      key: _formkey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ระบุข้อมูลการเข้ารับบริการ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 9,
              color: Color(0xFF473F97),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    selectDatePicker(context);
                  },
                  child: TextFormField(
                    controller: _txtDate,
                    enabled: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'วันที่',
                      hintText: 'กรุณากดเพื่อเลือกวันที่',
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
                    // validator: (value) {
                    //   print('value:${value}');
                    //   if (value == null || value.isEmpty) {
                    //     return 'กรุณาเลือกวันที่';
                    //   }
                    //   return null;
                    // },
                    // onSaved: (value) {
                    //   _last_name = value;
                    // },
                    // initialValue: _dateSelected == null
                    //     ? 'กดปุ่มเลือกวันที่'
                    //     : _dateSelected!,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                'จุดรับบริการ',
                style: TextStyle(
                  color: iBlackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton<Hospitel>(
                isExpanded: true,
                value: _selectHospitel,
                style: TextStyle(color: iBlueColor, fontFamily: fontRegular),
                underline: Container(
                  height: 2,
                  color: iBlueColor,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectHospitel = newValue;
                    _avaliableQueue = newValue!.avaliableQueue;
                    _allQueue = newValue.allQueue;
                    context.read<BookingModel>().hospital_name =
                        newValue.name;
                  });
                },
                items: items
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                'คิวที่ว่าง',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 9,
              color: Color(0xFF473F97),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10.0),
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF473F97)),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _avaliableQueue == 0 || _avaliableQueue == null
                              ? '-'
                              : _avaliableQueue.toString(),
                          style: TextStyle(
                              color: Color(0xFF473F97),
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontRegular),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 150),
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

                      if (_dateSelected == null || _dateSelected!.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('แจ้งเตือน'),
                              content: Text('กรุณาเลือกวันที่'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ตกลง')
                                ),
                              ],
                            );
                          }
                        );
                      } else if (_selectHospitel == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('แจ้งเตือน'),
                              content:
                                  Text('กรุณาเลือกจุดรับบริการ'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('ตกลง')),
                              ],
                            );
                          }
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('ยืนยัน'),
                              content: Text(
                                  'คุณต้องการยืนยันการจองคิวเข้ารับการตรวจและรับรองว่าข้อมูลดังกล่าวถูกต้องแล้ว'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('ไม่ใช่')),
                                TextButton(
                                  onPressed: () {
                                    _queue_number++;
                                    context.read<BookingModel>().queue_number = _queue_number;

                                    //Add Booking to List
                                    List<BookingItem> listBooking = [];
                                    if (context.read<BookingListModel>().bookingList != null) {
                                      listBooking = context.read<BookingListModel>().bookingList;
                                    }
                                    listBooking.add(BookingItem(
                                      hospitalName: _selectHospitel!.name,
                                      checkDate: _dateSelected!,
                                      result: 'ไม่ติดเชื้อ',
                                    ));
                                    context.read<BookingListModel>().bookingList = listBooking;

                                    //ข้อ 2 d.มีการนาinput จาก Form ส่งต่อไปแสดงผลยังอีกหน้า ผ่าน Navigatorจะเป็นแบบ Forward หรือBackward
                                    //ทำแบบ Forward
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BookingSummaryScreen(
                                                    all_queue: _allQueue)),
                                        (route) => false);
                                  },
                                  child: Text('ใช่')
                                ),
                              ],
                            );
                          }
                        );
                      }
                    }
                  },
                  child: Text('ถัดไป',
                      style: TextStyle(fontSize: 20, color: iWhiteColor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Hospitel {
  String name;
  int avaliableQueue;
  int allQueue;

  Hospitel(
      {required this.name,
      required this.avaliableQueue,
      required this.allQueue});
}
