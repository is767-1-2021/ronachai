import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:icovid/pages/bottom_nav_page.dart';
import 'package:icovid/pages/hospital_home_page.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'constants/font_sonstant.dart';
import 'models/booking_list_model.dart';
import 'models/hospital_model.dart';
import 'models/patient_form_model.dart';
import 'models/patient_form_model_hospitel.dart';
import 'models/profile_model.dart';
import 'models/user_provider.dart';

void main() {
  runApp(
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
         ChangeNotifierProvider( //ของกิ๊ฟ
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider( //ของโบนัส
          create: (context) => HospitalFormModel(),
        ),
         ChangeNotifierProvider( //ของแตง
          create: (context) => PatientFormModel(),
        ),
         ChangeNotifierProvider( //ของแตง
          create: (context) => PatientFormModelHospitel(),
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
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/launcher_icon.png'),
        duration: 2500,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: iWhiteColor,
        nextScreen: LogInScreen(),
      ),
    );
  }
}
