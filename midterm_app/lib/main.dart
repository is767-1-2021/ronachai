import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/booking_step1_page.dart';
import 'package:provider/provider.dart';

import 'constants/color_constant.dart';
import 'constants/font_sonstant.dart';
import 'models/booking_list_model.dart';
import 'models/booking_model.dart';
import 'models/profile_model.dart';
import 'pages/bottom_nav_page.dart';
import 'pages/fifth_page.dart';
import 'pages/fourth_page.dart';
import 'pages/home_screen.dart';
import 'pages/rbooking_list_page.dart';
import 'pages/sixth_page.dart';

void main() {
  runApp(
    //ข้อ 3 b.ใช้ MultiProviderใน runApp()
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookingModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingListModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i-Covid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: fontRegular,
      ),
      //ข้อ 1 c.มีการสร้าง Named Routes สาหรับใช้ในการ Navigate ไปยัง Page ต่าง ๆ
      routes: <String, WidgetBuilder>{
        '/1': (context) => BottomNavScreen(), //i.ให้2 ปุ่มแรก Navigate ไปยังPage ที่จะทาในข้อ2
        '/2': (context) => BookingStep1Screen(), //i.ให้2 ปุ่มแรก Navigate ไปยังPage ที่จะทาในข้อ2
        '/3': (context) => BookingListcreen(), //i.ให้2 ปุ่มแรก Navigate ไปยังPage ที่จะทาในข้อ2
        '/4': (context) => FourthPage(), //ii.สร้าง Blank Page สาหรับใช้ในการทดสอบ Menu Button ที่ยังไม่ได้สร้างหน้า UI และเชื่อมโยงกับ Menu Button ให้เรียบร้อย
        '/5': (context) => FifthPage(), //ii.สร้าง Blank Page สาหรับใช้ในการทดสอบ Menu Button ที่ยังไม่ได้สร้างหน้า UI และเชื่อมโยงกับ Menu Button ให้เรียบร้อย
        '/6': (context) => SixPage(), //ii.สร้าง Blank Page สาหรับใช้ในการทดสอบ Menu Button ที่ยังไม่ได้สร้างหน้า UI และเชื่อมโยงกับ Menu Button ให้เรียบร้อย
      },
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/launcher_icon.png'),
        duration: 2500,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: iWhiteColor,
        nextScreen: HomePage(),
      ),
    );
  }
}
