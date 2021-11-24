import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/constants/font_sonstant.dart';
import 'package:icovid/controllers/booking_controller.dart';
import 'package:icovid/models/booking_provider_model.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/hospital_clas.dart';
import 'package:icovid/pages/booking_summary.dart';
import 'package:icovid/services/booking_service.dart';
import 'package:provider/provider.dart';

class BookingStep2Screen extends StatelessWidget {
  const BookingStep2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STEP 2 : ข้อมูลการรับบริการ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
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
  int _hospitalNumber = 0;
  int _queue_number = 0;
  var _txtDate = TextEditingController();
  String? _dateSelected;
  BHospital? _selectHospitel;
  String? _hosName;
  List<BHospital> hospitalList = List.empty();
  // var service = FirebaseServices();
  // BookingController controller = BookingController(service);
  var service = BookingServices();
  var controller;
  _LogInCustomState() {
    controller = BookingController(service);
  }

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  Future<Null> selectDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
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
        context.read<BookingModel>().booking_date =
            '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  @override
  void initState() {
    _getHospitalList();
  }

  void _getHospitalList() async {
    hospitalList = await controller.fecthHospitalList();
  }

  @override
  Widget build(BuildContext context) {
    //_queue_number = context.read<BookingModel>().queue_number;

    //Get data from provider

    // final value = context.watch<HospitalFormModel?>();
    // if (value != null) {
    //    List<Hospital> _hospitalList2 = [];
    //   _hospitalList2 = context.read<HospitalFormModel>().hospitalList;
    //   print('hos length: ${_hospitalList2.length}');
    // }
    List<DropdownMenuItem<BHospital>> items = [];
    // items = hostpitalListBooking.map((item) {
    //   return DropdownMenuItem<Hospital>(
    //     child: Text(item.hospitalName!),
    //     value: item,
    //   );
    // }).toList();

    // if (items.isEmpty) {
    //   items = [
    //     DropdownMenuItem(
    //       child: Text(_selectHospitel!.hospitalName!),
    //       value: _selectHospitel,
    //     )
    //   ];
    // }

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
              color: iBlueColor,
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
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton<BHospital>(
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
                    _avaliableQueue = newValue!.avaliable_queue;
                    _allQueue = newValue.no_patient;
                    _hospitalNumber = newValue.hospital_number;
                    context.read<BookingModel>().hospital_name =
                        newValue.hospital_name;
                    _hosName = newValue.hospital_name;
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
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                'คิวที่ว่าง',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 9,
              color: iBlueColor,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10.0),
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: iBlueColor),
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
                              color: iBlueColor,
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
              child: Consumer<BookingModel>(builder: (context, form, child) {
                return Container(
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
                                        child: Text('ตกลง')),
                                  ],
                                );
                              });
                        } else if (_selectHospitel == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('แจ้งเตือน'),
                                  content: Text('กรุณาเลือกจุดรับบริการ'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('ตกลง')),
                                  ],
                                );
                              });
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
                                          print(
                                              '_avaliableQueue:${_avaliableQueue}');
                                          print('_allQueue:${_allQueue}');
                                          if (_avaliableQueue == 0) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('แจ้งเตือน'),
                                                    content: Text(
                                                        'ไม่สามารถจองได้เนื่องจากคิวเต็มแล้ว'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('ตกลง')),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            print('_avaliableQueue:${_avaliableQueue}');
                                            print('_allQueue:${_allQueue}');
                                            _queue_number =_avaliableQueue == _allQueue? 1: (_allQueue! -_avaliableQueue!) +1;
                                            print('_queue_number:${_queue_number}');
                                            context.read<BookingModel>().queue_number = _queue_number;

                                            //Add Booking to List
                                            List<Booking> listBooking = [];
                                            if (context
                                                    .read<BookingProvider>()
                                                    .bookingList !=
                                                null) {
                                              listBooking = context
                                                  .read<BookingProvider>()
                                                  .bookingList;
                                            }
                                            //add to State
                                            listBooking.add(Booking(
                                                _hosName!,
                                                _dateSelected!,
                                                '',
                                                '${form.first_name} ${form.last_name}',
                                                _hospitalNumber,
                                                "${form.id_card}",
                                                _queue_number));

                                            //add to firebase
                                            controller.addBooking(new Booking(
                                                _hosName!,
                                                _dateSelected!,
                                                '',
                                                '${form.first_name} ${form.last_name}',
                                                _hospitalNumber,
                                                "${form.id_card}",
                                                _queue_number));

                                            //update avaliable queue
                                            controller.updateAvaliableQueue(
                                                _hospitalNumber,
                                                _avaliableQueue! - 1);

                                            context
                                                .read<BookingProvider>()
                                                .bookingList = listBooking;

                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingSummaryScreen(
                                                            all_queue:
                                                                _allQueue)),
                                                (route) => false);
                                          }
                                        },
                                        child: Text('ใช่')),
                                  ],
                                );
                              });
                        }
                      }
                    },
                    child: Text('ถัดไป',
                        style: TextStyle(fontSize: 20, color: iWhiteColor)),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
