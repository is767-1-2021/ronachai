import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/booking_controller.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:icovid/services/booking_service.dart';
import 'package:provider/provider.dart';

import 'constants/font_sonstant.dart';
import 'models/booking_list_model.dart';
import 'models/hospital_model.dart';
import 'models/patient_form_model.dart';
import 'models/patient_form_model_hospitel.dart';
import 'models/profile_model.dart';
import 'models/user_provider.dart';
import 'pages/booking_step1_page.dart';
import 'pages/bottom_nav_page.dart';
import 'pages/hospital_home_page.dart';
import 'pages/list_user_page.dart';
import 'pages/patient_list_page.dart';
import 'pages/qr_scan_page.dart';
import 'pages/signup_page.dart';
import 'pages/ubooking_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var services = FirebaseServices();
  // var controller = BookingController(services);

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
        ChangeNotifierProvider(
          //ของกิ๊ฟ
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          //ของโบนัส
          create: (context) => HospitalFormModel(),
        ),
        ChangeNotifierProvider(
          //ของแตง
          create: (context) => PatientFormModel(),
        ),
        ChangeNotifierProvider(
          //ของแตง
          create: (context) => PatientFormModelHospitel(),
        ),
      ],
      child: BookingApp(),
    ),
  );
}

class BookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavScreen(),
      routes: <String, WidgetBuilder>{
        '/1': (context) => SignUpScreen(),
        '/2': (context) => LogInScreen(),
        '/3': (context) => BookingStep1Screen(),
        '/4': (context) => HospitalHomeScreen(),
        '/5': (context) => PatientListPage(),
        '/6': (context) => ListUser(),
      },
    );
  }
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
