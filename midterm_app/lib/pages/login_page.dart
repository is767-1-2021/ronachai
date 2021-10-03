import 'package:flutter/material.dart';
import 'package:midterm_app/widgets/login_form.dart';
import 'package:midterm_app/widgets/primary_button.dart';

import 'bottom_nav_page.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  late int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF473F97), //Colors.blue.shade800,
                Color(0xFF473F97) //Colors.blue.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "i-Covid",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "คุณเป็นสมาชิกแล้วหรือยัง?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SignUpScreen(),
                              //   ),
                              // );
                            },
                            child: Text(
                              "สมัครสมาชิก",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          LogInForm(Email, Password),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           ResetPasswordScreen()),
                              // );
                            },
                            child: Text(
                              'ลืมรหัสผ่าน?',
                              style: TextStyle(
                                color:
                                    Color(0xFF473F97), //Colors.blue.shade600,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavScreen(),
                                ),
                              );

                              // if ((Email.text == "chavisa@gmail.com") &&
                              //     (Password.text == "1234")) {
                              //   print(Email.text + " pass " + Password.text);
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => BottomNavScreen(),
                              //     ),
                              //   );
                              // } else {
                              //   print("error");
                              //   num = num + 1;
                              //   if (num > 3) {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //     builder: (context) =>
                              //     //         ResetPasswordScreen(),
                              //     //   ),
                              //     // );
                              //   }
                              //   // ScaffoldMessenger.of(context).showSnackBar(
                              //   //   const SnackBar(
                              //   //       content: Text(
                              //   //           'Email or Password is not correct')),
                              //   // );
                              //   /*
                              //   showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) =>
                              //         AlertDialog(
                              //       title: Text('No Data Email And Password'),
                              //     ),
                              //   );

                              //   print(
                              //       Email.text + "  no data  " + Password.text);
                              //   */
                              // }
                            },
                            child: PrimaryButton(buttonText: 'เข้าสู่ระบบ'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ))

              /*
              Text(
                "Or log in with",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LoginOption(),
              */
            ],
          ),
        ),
      ),
    );
  }
}
