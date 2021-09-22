import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/pages/bottom_nav_screen.dart';
import 'package:icovid/pages/home_page.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({ Key? key }) : super(key: key);

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('STEP 3 : รายละเอียดการจอง',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: iWhiteColor
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: Container(
       padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
          //  BarcodeGenerator(
          //     witdth: 300,
          //     height: 200,
          //     backgroundColor: Colors.red,
          //     fromString: "xxxxxxxx",
          //     codeType: BarCodeType.kBarcodeFormatCode128,
          //   )
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: iBlueColor,
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Barcode Generator',
                style: TextStyle(
                  color: iWhiteColor,
                  backgroundColor: iBlueColor
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: iWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('รหัสบัตรประชาชน:XXXXXXXXX5412'),
                  )
                  ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Card(
                    color: iWhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('ชื่อ:รณชัย'),
                    )
                  ),
                  Card(
                    color: iWhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('นามสกุล:จำศิล'),
                    )
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: iWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('เบอร์โทร:XXXXXX5789'),
                  )
                  ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: iWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('สถานที่ :โรงพยาบาลเกษมราษฏร์ประชาชื่น'),
                  )
                  ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: iWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('วันที่ :21/09/2021'),
                  )
                  ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: iWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('เวลา :09.00 - 10.00'),
                  )
                  ),
              ),
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
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => BottomNavScreen())
                  );
                }, 
                child: Text('กลับหน้าหลัก',
                style: TextStyle(
                fontSize: 20,
                color: iWhiteColor)),
              ),
            ),
          ],
        ),
      ),
    );
    // return ListView.builder(
    //   itemCount: data_info.length,
    //   itemBuilder: (context,pos){
    //     return Padding(
    //       padding: EdgeInsets.only(bottom: 16.0),
    //       child: Card(
    //         color: iWhiteColor,
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(vertical: 24.0),
    //           child: Text(data_info[pos].title),
    //         ),
    //       ),
    //     );
    //   },
    // );

  }
}