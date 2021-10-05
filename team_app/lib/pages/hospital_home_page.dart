import 'package:flutter/material.dart';

import 'hospital_booking_list_page.dart';
import 'hospital_home_body_page.dart';
import 'hospital_info_page.dart';

class HospitalHomeScreen extends StatefulWidget {
  const HospitalHomeScreen({Key? key}) : super(key: key);

  @override
  _HospitalHomeScreenState createState() => _HospitalHomeScreenState();
}

class _HospitalHomeScreenState extends State<HospitalHomeScreen> {
  final List _screensHospital = [
    HospitalHomeBodyScreen(),
    HospitalBookingList(),
    HostpitalInfoScreen(),
  ];
  int _currentIndexHospital = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screensHospital[_currentIndexHospital],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexHospital,
        onTap: (index) => setState(() => _currentIndexHospital = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [Icons.home,Icons.book_online, Icons.local_hospital]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    title: Text(''),
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: _currentIndexHospital == key
                            ? Colors.blue[600]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}
