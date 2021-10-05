import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/booking_list_model.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:provider/provider.dart';

class BookingListcreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BookingItem> _bookingList = [];
    if (context.read<BookingListModel>().bookingList != null) {
      _bookingList = context.read<BookingListModel>().bookingList;
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'รายการจองคิวของฉัน',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
          ),
        ),
        backgroundColor: iBlueColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
            },
          ),
        ],
      ),
      // body: ListView.separated(
      //   padding: EdgeInsets.all(8.0),
      //   itemCount: _bookingList.length,
      //   itemBuilder: (context, index) {
      //     return BookingTile(
      //       items: BookingItem(
      //       hospitalName: '${_bookingList[index].hospitalName}',
      //       checkDate: '${_bookingList[index].checkDate}',
      //       result: '${_bookingList[index].result}',
      //       )
      //     );
      //   },
      //   separatorBuilder: (context, index) => Divider(),
      // ),
      body: ListView.builder(
        itemCount: _bookingList.length,
        itemBuilder: (context, int index) {
          //User data = provider.users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                  child: Icon(Icons.book_online),
                ),
              ),
              title: Text('${_bookingList[index].hospitalName}'),
              subtitle: Text('${_bookingList[index].checkDate}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookingDetail(items: _bookingList[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BookingItem {
  final String hospitalName;
  final String checkDate;
  final String result;
  final String fullName;

  const BookingItem(
      {Key? key,
      required this.hospitalName,
      required this.checkDate,
      required this.result,
      required this.fullName
      });
}

// class BookingTile extends StatelessWidget {
//   final BookingItem items;
//   const BookingTile({Key? key, required this.items}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => BookingDetail(items: items)));
//       },
//       child: Container(
//         height: 50,
//         color: Color(0xFF473F97).withOpacity(0.5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   '${items.hospitalName}-${items.checkDate}',
//                   style: TextStyle(color: Color(0xFF473F97)),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('${items.result}',
//                 style: TextStyle(color: Color(0xFF473F97)),
//                 ),
//               ),
//             ]
//           ),
//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.start,
//           //   children: [
//           //       Text('${items.checkDate}',
//           //       style: TextStyle(color: Color(0xFF473F97)),
//           //     ),
//           //   ],
//           // ),
//           ]
//         ),
//       ),
//     );
//   }
// }

class BookingDetail extends StatelessWidget {
  final BookingItem items;
  const BookingDetail({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'รายละเอียดการจอง',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: iWhiteColor),
          ),
        ),
        backgroundColor: Color(0xFF473F97),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 28.0,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'โรงพยาบาลที่เข้ารับการตรวจ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.hospitalName}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'วันที่เข้ารับการตรวจ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.checkDate}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ผลการตรวจ',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${items.result}',
            ),
          ],
        ),
      ),
    );
  }
}
