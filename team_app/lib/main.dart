import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/booking_model.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'constants/font_sonstant.dart';
import 'models/profile_model.dart';

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
