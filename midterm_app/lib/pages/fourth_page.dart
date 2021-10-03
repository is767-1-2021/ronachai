import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/constants/color_constant.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///ข้อ 1 c iii.ทุกหน้าต้องสามารถ Navigate backward ได้ เช่น ใช้Scaffold และAppBar
    return Scaffold(
      appBar: AppBar(
        title: Text('Fourth Page'),
        backgroundColor: iBlueColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Fourth Page'),
          ],
        ),
      ),
    );
  }
}
