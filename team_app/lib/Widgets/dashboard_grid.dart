import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/dashboard_controller.dart';
import 'package:icovid/models/dashboard_model.dart';
import 'package:icovid/services/dashboard_service.dart';

class DashboardGrid extends StatefulWidget {
  @override
  _DashboardGridState createState() => _DashboardGridState();
}

class _DashboardGridState extends State<DashboardGrid> {
  var service = HttpServices();
  var controller;
  _DashboardGridState() {
    controller = DashboardController(service);
  }

  List<CovidStat> statList = List.empty();

  @override
  void initState() {
    super.initState();
    _getCovidStatistics();
  }

  void _getCovidStatistics() async {
    var newStatList = await controller.getCovidStatistics();
    setState(() {
      statList = newStatList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return InkWell(
          onTap: () {
            //Navigator.pushNamed(context, '/${index + 1}');
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: iBlueColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(statList[index].new_case.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ));
    // return Container(
    //   height: MediaQuery.of(context).size.height * 0.25,
    //   child: Column(
    //     children: <Widget>[
    //       Flexible(
    //         child: Row(
    //           children:[
    //             _buildStatCard('รับการตรวจทั้งหมด', '1.81 M', Colors.orange),
    //             _buildStatCard('จองคิวแล้ว', '105 K', Colors.lightBlue),
    //              _buildStatCard('ไม่ติดเชื้อ', '391 K', Colors.green),
    //             _buildStatCard('ติดเชื้อ', '1.31 M', Colors.red),
    //             _buildStatCard('ส่งต่อ', '10 K', Colors.purple),
    //           ],
    //         ),
    //       ),
    //       Flexible(
    //         child: Row(
    //           children: [
    //             _buildStatCard('ไม่ติดเชื้อ', '391 K', Colors.green),
    //             _buildStatCard('ติดเชื้อ', '1.31 M', Colors.red),
    //             _buildStatCard('ส่งต่อ', '10 K', Colors.purple),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
