import 'package:flutter/material.dart';

class HBookingListScreen extends StatelessWidget {
 final List<String> entries = <String>['ปฎิทิน','อรพรรณ','ทะเล','นวลนาง','E','F','G'];
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'รายชื่อผู้เข้ารับการตรวจ',
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){
                // Navigator.push(context, 
                //   MaterialPageRoute(
                //     builder: (context) => DOPAAddScreen()
                //     )
                // );

            }, 
            icon: Icon(Icons.add))
          ],
          backgroundColor: Color(0xFF473F97),
        ),
        //
        body: ListView(
          children: <Widget>[
            ListTile(
             leading: Icon(Icons.calendar_today),
              title : Text ('ปฎิทิน'),
            ),
            ListTile(
             leading: Icon(Icons.people),
              title : Text ('นาย ก.'),
            ),
            ListTile(
             leading: Icon(Icons.people),
              title : Text ('นาย ข.'),
            ),
          ],
        ),
      );
  }
}