import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/pages/booking_step2_page.dart';

class BookingStep1Screen extends StatelessWidget {
  const BookingStep1Screen({ Key? key }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STEP 1 : ข้อมูลทั่วไป',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: iWhiteColor
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: Step1Custom(),
    );
  }
}

class Step1Custom extends StatefulWidget {
  const Step1Custom({ Key? key }) : super(key: key);

  @override
  _LogInCustomState createState() => _LogInCustomState();
}

class _LogInCustomState extends State<Step1Custom> {
  final _formkey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'หมายเลขบัตรประจำตัวประชาชน',
                labelStyle: TextStyle(
                  color: iBlackColor,
                ),
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: iBlueColor),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),  
              ),
              keyboardType: TextInputType.number,
              maxLength: 13,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ชื่อ',
                labelStyle: TextStyle(
                  color: iBlackColor,
                ),
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: iBlueColor),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),  
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'นามสกุล',
                labelStyle: TextStyle(
                  color: iBlackColor,
                ),
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: iBlueColor),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),  
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'เบอร์โทรศัพท์',
                hintText: 'กรอกเฉพาะตัวเลข 10 หลักติดกันไม่ต้องมีขีดขั้น',
                labelStyle: TextStyle(
                  color: iBlackColor,
                ),
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: iBlueColor),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),  
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width:MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                ),
                color: iBlueColor,
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => BookingStep2Screen())
                  );
                }, 
                child: Text('ถัดไป',
                style: TextStyle(
                fontSize: 20,
                color: iWhiteColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}