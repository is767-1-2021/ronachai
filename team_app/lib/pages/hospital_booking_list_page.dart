import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/booking_list_model.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'ubooking_list_page.dart';

class HospitalBookingList extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    List<BookingItem> _bookingList = [];
    if (context.read<BookingListModel>().bookingList != null) {
      _bookingList = context.read<BookingListModel>().bookingList;
    }
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
              icon: Icon(Icons.logout),
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen())
                );
              },
            ),
          ],
          backgroundColor: Color(0xFF473F97),
        ),
        //
        body: ListView.builder(
        itemCount: _bookingList.length,
        itemBuilder: (context, int index) {
          //User data = provider.users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                  child: Text('${index+1}',
                    style: TextStyle(color: iWhiteColor,fontSize: 20),
                  ),
                ),
              ),
              title: Text('${_bookingList[index].fullName}'),
              subtitle: Text('${_bookingList[index].checkDate}'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BookingDetail(items: _bookingList[index]),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}