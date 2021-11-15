import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_controller.dart';
import 'package:icovid/models/booking_list_model.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:icovid/services/booking_service.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_page.dart';

class BookingListcreen extends StatefulWidget {
  // final BookingController controller;
  // BookingListcreen({required this.controller});
  var service = FirebaseServices();
  var controller;
  BookingListcreen() {
    controller = BookingController(service);
  }

  @override
  _BookingListcreenState createState() => _BookingListcreenState();
}

class _BookingListcreenState extends State<BookingListcreen> {
  List<Booking> bookings = List.empty();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getBookings();
  }

  void _getBookings() async {
    var bookingList = await widget.controller.fecthBookings();
    setState(() {
      bookings = bookingList;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: bookings.isEmpty ? 1 : bookings.length,
          itemBuilder: (context, index) {
            if (bookings.isEmpty) {
              return Text('ไม่พบรายการจอง');
            }
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Icon(Icons.book_online),
                  ),
                ),
                title: Text('${bookings[index].hospitalName}'),
                subtitle: Text('${bookings[index].checkDate}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingDetail(items: bookings[index]),
                    ),
                  );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    List<BookingItem> _bookingList = [];
    if (context.read<BookingListModel>().bookingList != null) {
      _bookingList = context.read<BookingListModel>().bookingList;
    }
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'รายการจองคิวของฉัน',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: iWhiteColor),
            ),
          ),
          backgroundColor: iBlueColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavScreen()));
              },
            ),
          ],
        ),
        body: Center(
          child: body,
        ));
  }
}

class BookingItem {
  final String hospitalName;
  final String checkDate;
  final String result;
  final String fullName;

  const BookingItem(
      {Key? key,
      required this.hospitalName,
      required this.checkDate,
      required this.result,
      required this.fullName});

  add(Map<String, String> map) {}
}

class BookingDetail extends StatelessWidget {
  final Booking items;
  const BookingDetail({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'รายละเอียดการจอง',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
          ),
        ),
        backgroundColor: Color(0xFF473F97),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () {},
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
                labelText: 'โรงพยาบาลที่เข้ารับการตรวจ',
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
              initialValue: '${items.hospitalName}',
            ),
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
              initialValue: '${items.checkDate}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ผลการตรวจ',
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
              initialValue: '${items.result}',
            ),
          ],
        ),
      ),
    );
  }
}
