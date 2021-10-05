
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/widgets/primary_button.dart';
import 'package:icovid/widgets/reset_form.dart';

import 'login_page.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iBlueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "ตั้งค่ารหัสผ่านใหม่",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 5,
              ),
              Text("กรุณาระบุอีเมล์"),
              ResetForm(),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                },
                child: PrimaryButton(buttonText: "ตกลง",buttonColor: iBlueColor,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}