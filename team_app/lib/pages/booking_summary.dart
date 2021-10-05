import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_page.dart';

class BookingSummaryScreen extends StatefulWidget {
  int? all_queue;
  BookingSummaryScreen({Key? key, this.all_queue}) : super(key: key);

  @override
  _BookingSummaryState createState() => _BookingSummaryState(all_queue);
}

class _BookingSummaryState extends State<BookingSummaryScreen> {
  int? all_queue;
  _BookingSummaryState(this.all_queue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'จองคิวเรียบร้อย',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: iBlueColor,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        //ข้อ 3 d.ใช้ Consumer สาหรับนาข้อมูลจากState มาแสดง
        child: Consumer<BookingModel>(
          builder: (context, form, child) {
            return Container(
              child: Column(
                children: [
                  Text('กรุณาแสดง qrcode ให้เจ้าหน้าที่สแกน'),
                  BarcodeWidget(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    data:
                        '${form.id_card} ${form.first_name} ${form.last_name} ${form.tel} ${form.hospital_name} ${form.booking_date} ${form.booking_time}',
                    barcode: Barcode.qrCode(),
                    color: iBlueColor,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      'คิวที่',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    //width: 20,
                    child: Text(
                      '${context.read<BookingModel>().queue_number.toString()}/${all_queue}',
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          color: iWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                                'รหัสบัตรประชาชน: ${form.id_card.toString().substring(0, 3)}xxxxxxx${form.id_card.toString().substring(10, 13)}'),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          color: iWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('ชื่อ: ${form.first_name}'),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          color: iWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('นามสกุล: ${form.last_name}'),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          color: iWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                                'เบอร์โทร: ${form.tel.toString().substring(0, 3)}xxxx${form.tel.toString().substring(8, 10)}'),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          color: iWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('สถานที่ตรวจ : ${form.hospital_name}'),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          color: iWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('วันที่ตรวจ : ${form.booking_date}'),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: iBlueColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavScreen()));
                      },
                      child: Text('กลับหน้าหลัก',
                          style: TextStyle(fontSize: 20, color: iWhiteColor)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
