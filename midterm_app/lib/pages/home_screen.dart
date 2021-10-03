import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/constants/color_constant.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ข้อ 1 a.มี Menu Button สาหรับเชื่อมไปสู่หน้าต่าง ๆ โดยให้มีอย่างน้อย 6 ปุ่ม
    final List<Icon> _iconList = <Icon>
    [
      Icon(Icons.home_filled,color: iBlueColor,size: 60,),Icon(Icons.book_online,color: iBlueColor,size: 60,),
      Icon(Icons.ballot,color: iBlueColor,size: 60,),Icon(Icons.filter_4,color: iBlueColor,size: 60,),
      Icon(Icons.filter_5,color: iBlueColor,size: 60,),Icon(Icons.filter_6,color: iBlueColor,size: 60,),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Home',
            style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w700, 
                color: iWhiteColor
              ),
            ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/${index + 1}');
            },
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: iBlueColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //ข้อ 1 b.ตัว Menu Button แต่ละอันจะต้องมี Icon และ Caption
                    _iconList[index],
                    Text(
                      index+1 == 1 ? 'หน้าหลัก': index+1 == 2 ? 'จองคิว':index+1 == 3 ?'รายการจอง':'Page ${index + 1}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
