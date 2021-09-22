import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/pages/booking_summary.dart';

class BookingStep2Screen extends StatelessWidget {
  const BookingStep2Screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('STEP 2 : สถานที่/วันที่/เวลา',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: iWhiteColor
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: Step2Custom(),
    );
  }
}

class Step2Custom extends StatefulWidget {
  const Step2Custom({ Key? key }) : super(key: key);

  @override
  _LogInCustomState createState() => _LogInCustomState();
}

class _LogInCustomState extends State<Step2Custom> {
  final _formkey = GlobalKey<State>();
  String dropdownValue = 'โรงพยาบาลเกษมราษฏร์ประชาชื่น';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  Future<Null> selectDatePicker(BuildContext context) async{
    final DateTime? datePicked = await showDatePicker(
        context: context, 
        initialDate: date, 
        firstDate: DateTime(1940), 
        lastDate: DateTime(2030)
      );
      if(datePicked != null && datePicked != date){
        setState(() {
          date = datePicked;
        });
      }
  }

  Future<Null> selectTimePicker(BuildContext context) async{
    TimeOfDay? timePicked = await showTimePicker(
        context: context, 
        initialTime: time
      );

      if(timePicked != null){
        setState(() {
          time = timePicked;
        });
      }
  }


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
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                   FlatButton(
                    child: Text('สถานที่',
                      style: TextStyle(
                        color: iWhiteColor
                      ),
                    ),
                    onPressed: (){},
                    color: iBlueColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      //elevation: 16,
                      style: TextStyle(color: iBlueColor),
                      underline: Container(
                        height: 2,
                        color: iBlueColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['โรงพยาบาลเกษมราษฏร์ประชาชื่น', 'โรงพยาบาลบำรุงราษฎร์', 'โรงพยาบาลวิภาวดี']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               FlatButton(
                child: Text('วันที่',
                  style: TextStyle(
                    color: iWhiteColor
                  ),
                ),
                onPressed: (){
                  selectDatePicker(context);
                },
                color: iBlueColor,
               ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('${date.day}/${date.month}/${date.year}',
                  textAlign: TextAlign.center,
                ),
              ),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
              FlatButton(
                child: Text('เวลา',
                  style: TextStyle(
                    color: iWhiteColor
                  ),
                ),
                onPressed: (){
                  selectTimePicker(context);
                },
                color: iBlueColor,
               ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text('${time.hour}:${date.minute}:${date.second}',
                    textAlign: TextAlign.center,
                  ),
                  
                ),
              ),
             ],
           ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                ),
                color: iBlueColor,
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('ยืนยัน'),
                        content: Text('คุณต้องการยืนยันการจองและรับรองว่าข้อมูลดังกล่าวถูกต้องแล้ว'),
                        actions: [
                            FlatButton(
                            onPressed: (){
                              Navigator.pop(context);
                            }, 
                            child: Text('ไม่ใช่')
                          ),
                          FlatButton(
                            onPressed: (){
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => BookingSummaryScreen())
                              );
                            }, 
                            child: Text('ใช่')
                          ),
                        ],
                      );
                    }
                  );
                }, 
                child: Text('ถัดไป',
                style: TextStyle(
                fontSize: 20,
                color: iWhiteColor)),
              ),
              // child: CupertinoAlertDialog(
              //   title: Text('ยืนยัน'),
              //   content: Text('คุณต้องการยืนยันการจองและรับรองว่าข้อมูลดังกล่าวถูกต้องแล้ว'),
              //   actions: [
              //     FlatButton(
              //       onPressed: (){
              //           Navigator.push(context, 
              //           MaterialPageRoute(builder: (context) => BookingSummaryScreen())
              //         );
              //       }, 
              //       child: Text('ใช่')
              //     ),
              //       FlatButton(
              //       onPressed: (){}, 
              //       child: Text('ไม่ใช่')
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}