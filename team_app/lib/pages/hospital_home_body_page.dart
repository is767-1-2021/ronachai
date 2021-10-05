import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid/data/data.dart';
import 'package:icovid/pages/booking_step1_page.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:icovid/pages/qr_scan_page.dart';

class HospitalHomeBodyScreen extends StatefulWidget {
  const HospitalHomeBodyScreen({Key? key}) : super(key: key);

  @override
  _HospitalHomeBodyScreenState createState() => _HospitalHomeBodyScreenState();
}

class _HospitalHomeBodyScreenState extends State<HospitalHomeBodyScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF473F97),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.person_outline),
          iconSize: 30.0,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _headerSection(screenHeight),
          _preventionTipsSection(screenHeight),
          _BookingSection(screenHeight)
        ],
      ),
    );
  }

  Size get PreferredSize => Size.fromHeight(kToolbarHeight);

  SliverToBoxAdapter _headerSection(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFF473F97),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ยินดีต้อนรับ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'เจ้าหน้าที่โรงพยาบาล',
                  style: TextStyle(color: Colors.white70, fontSize: 15.0),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanQR_Page()));
                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                  ),
                  label: Text(
                    'สแกนด่วน',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _preventionTipsSection(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'แนวทางป้องกัน',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention
                  .map((e) => Column(
                        children: [
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.12,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            e.values.first,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _BookingSection(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFAD9FE4), Color(0xFF473F97)],
            ),
            borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/own_test.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เพราะคุณคือคนสำคัญ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'พวกเราจะผ่านเหตุการณ์นี้ไปด้วยกัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
