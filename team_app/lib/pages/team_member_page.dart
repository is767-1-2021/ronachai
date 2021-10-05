import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/pages/login_page.dart';

class TeamMemberScreen extends StatefulWidget {
  const TeamMemberScreen({Key? key}) : super(key: key);

  @override
  _TeamMemberScreenScreenState createState() => _TeamMemberScreenScreenState();
}

class _TeamMemberScreenScreenState extends State<TeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iBlueColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF473F97),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.person_outline),
          iconSize: 30.0,
          onPressed: () {},
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
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(
              'ทีมผู้พัฒนา',
              style: TextStyle(
                color: iWhiteColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text('6302037343\nนายรณชัย จำศิล')])),
                    Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('6302037335\nนางสาวปณิตา ธาราภูมิ')
                            ])),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('6302037244\nนางสาวกนกพร มาพันดุง')
                            ])),
                    Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('6302037251\nนางสาวชวิสา สันตะวานนท์')
                            ])),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 330,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('6302037327\nนางสาวอรพรรณ ตาละลักษณ์')
                            ])),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
