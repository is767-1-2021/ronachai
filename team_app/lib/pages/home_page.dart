import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/auth_controller.dart';
import 'package:icovid/data/data.dart';
import 'package:icovid/models/resule_model.dart';
import 'package:icovid/pages/booking_step1_page.dart';
import 'package:icovid/services/auth_service.dart';

import 'bottom_nav_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  var service = AuthService();
  var controller;
  _HomeScreenState() {
    controller = AuthController(service);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    var user = auth.currentUser;

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
            icon: user == null ? Icon(Icons.login): Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () async{
              if(user == null){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('แจ้งเตือน'),
                      content: Text('คุณยังไม่ได้ลงชื่อเข้าใช้งานระบบ'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('ตกลง'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                        )
                      ],
                    );
                  },
                );
              }else{
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('แจ้งเตือน'),
                    content: Text('คุณต้องการออกจากระบบหรือไม่?'),
                    actions: [
                       ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('ยกเลิก'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent
                          ),
                      ),
                      ElevatedButton(
                          onPressed: () async{
                            Result result = await controller.SignOut();
                            if(result.result){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('แจ้งเตือน'),
                                    content: Text('ออกจากระบบเรียบร้อย'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => BottomNavScreen()),
                                          (route) => false);
                                        },
                                        child: Text('ตกลง'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('แจ้งเตือน'),
                                    content: Text('ขออภัยไม่สามารถออกจากระบบได้กรุณาลองใหม่อีกครั้ง ${result.msg}'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ตกลง'))
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('ตกลง'),
                           style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                      )
                    ],
                  );
                },
              );
            }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _headerSection(screenHeight),
          _preventionTipsSection(screenHeight),
          //_BookingSection(screenHeight),
          _Menu(screenHeight)
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
            SizedBox(height: screenHeight * 0.01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'คุณรู้สึกป่วยหรือไม่?',
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
                  'หากคุณมีอาการเกี่ยวกับ Covid-19 เราแนะนำให้คุณเข้ารับการตรวจ เพื่อคนที่คุณรัก',
                  style: TextStyle(color: Colors.white70, fontSize: 15.0),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
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
                            builder: (context) => BookingStep1Screen()));
                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: Icon(
                    Icons.event_note,
                    color: Colors.white,
                  ),
                  label: Text(
                    'จองคิว',
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
                            height: screenHeight * 0.07,
                          ),
                          SizedBox(height: screenHeight * 0.005),
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
                  'จองคิวเลย !',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'นัดหมายตรวจ Covid-19\nล่วงหน้ากับ i-Covid.',
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

  SliverToBoxAdapter _Menu(double screenHeight) {
    final List<Icon> _iconList = <Icon>
    [
      Icon(Icons.app_registration,color: Colors.white,size: 30,),Icon(Icons.login,color: Colors.white,size: 30,),
      Icon(Icons.event_note,color: Colors.white,size: 30,),Icon(Icons.local_hospital,color: Colors.white,size: 30,),
      Icon(Icons.local_hospital_rounded,color: Colors.white,size: 30,),Icon(Icons.admin_panel_settings,color: Colors.white,size: 30,),
    ];
    return SliverToBoxAdapter(
      child: Container(
        height: screenHeight *0.35,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                var user = auth.currentUser;
                if(index + 1 == 1 || index + 1 == 2){
                  Navigator.pushNamed(context, '/${index + 1}');  
                }else if(user == null){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('แจ้งเตือน'),
                        content: Text('กรุณาลงชื่อเข้าใช้งานระบบ!'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ตกลง'))
                        ],
                      );
                    },
                  );
                }else{
                    Navigator.pushNamed(context, '/${index + 1}');  
                }
              },
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iBlueColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _iconList[index],
                      Text(
                        index+1 == 1 ? 'ลงทะเบียน': index+1 == 2 ? 'เข้าสู่ระบบ':index+1 == 3 ?'จองคิว':index+1 == 4 ?'รพ.':index+1 == 5 ?'รพ.สนาม':'ผู้ดูแลระบบ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
    ),
      ));
  }
}
