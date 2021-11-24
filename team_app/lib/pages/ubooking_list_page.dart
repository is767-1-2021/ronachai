import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/auth_controller.dart';
import 'package:icovid/controllers/booking_controller.dart';
import 'package:icovid/models/booking_provider_model.dart';
import 'package:icovid/models/booking_class_model.dart';
import 'package:icovid/models/user_profile_provider.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:icovid/services/auth_service.dart';
import 'package:icovid/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingListcreen extends StatefulWidget {
  var service = BookingServices();
  var authService = AuthService();
  var controller;
  var authController;
  BookingListcreen() {
    controller = BookingController(service);
    authController = AuthController(authService);
  }

  @override
  _BookingListcreenState createState() => _BookingListcreenState();
}

class _BookingListcreenState extends State<BookingListcreen> {
  List<Booking> _bookingList = [];
  bool isLoading = false;
  UserProfileProvider _profile = UserProfileProvider();
  final auth = FirebaseAuth.instance;
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? id_card="1111111111111";

  @override
  void initState() {
    super.initState();
    widget.controller.onSync.listen((bool syncState) => setState(() => isLoading = syncState));
    widget.authController.onSyncAuth.listen((bool syncState) => setState(() => isLoading = syncState));
  }

  void _getBookings(BuildContext context) async {
    // final SharedPreferences prefs = await _prefs;
    // String a = prefs.getString('id_card')?? '';
    // print('a--->${a}');
    var bookingList = await widget.controller.fecthMyBookings(id_card);
    setState(() {
        context.read<BookingProvider>().bookingList = bookingList;
    });
  }

  void _cancelQueue(String idCardNumber, int bookingNumber, int hopitalNumber,BuildContext context) async {
    await widget.controller.cancelQueue(idCardNumber, bookingNumber, hopitalNumber);
    var bookingList = await widget.controller.fecthMyBookings(id_card);
    setState(() {
      context.read<BookingProvider>().bookingList = bookingList;
    });
  }

   void _loadProfile() async{
    var newProfile = await widget.controller.GetUserInfo(auth.currentUser!.email);
    setState(()  {
      _profile = newProfile;
      id_card = _profile.cid;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _bookingList.isEmpty ? 1 : _bookingList.length,
          itemBuilder: (context, index) {
            if (_bookingList.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 300),
                      child: Text('ไม่พบรายการจอง')));
            }
            return Card(
              child: ListTile(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('แจ้งเตือน'),
                          content: Text(
                              'ยืนยันการยกเลิกคิวที่ ${_bookingList[index].bookingNumber}'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('ยกเลิก')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _cancelQueue(
                                        _bookingList[index].idCardNumber,
                                        _bookingList[index].bookingNumber,
                                        _bookingList[index].hospitalNumber,
                                        context);
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('ยืนยัน')),
                          ],
                        );
                      });
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // content: Text(' ถูกลบ')));
                },
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text(
                      '${_bookingList[index].bookingNumber}',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                title: Text('${_bookingList[index].hospitalName}'),
                subtitle: Text('วันที่ตรวจ ${_bookingList[index].checkDate}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingDetail(items: _bookingList[index]),
                    ),
                  );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    _getBookings(context);
    if (context.read<BookingProvider>().bookingList != null) {
      _bookingList = context.read<BookingProvider>().bookingList;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'รายการจองคิวของฉัน',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: iWhiteColor),
          ),
          backgroundColor: iBlueColor,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()));
              },
            ),
          ],
        ),
        body: Center(
          child: body,
        ));
  }
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
                labelText: 'คิวที่',
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
              initialValue: '${items.bookingNumber}',
            ),
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
