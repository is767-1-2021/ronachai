import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/dashboard_controller.dart';
import 'package:icovid/models/dashboard_model.dart';
import 'package:icovid/pages/login_page.dart';
import 'package:icovid/services/dashboard_service.dart';
import 'package:intl/intl.dart' as intl;

class DashboardScreen extends StatefulWidget {
  var service = HttpServices();
  var controller;
  DashboardScreen() {
    controller = DashboardController(service);
  }

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = false;
  List<CovidStat> stateList = List.empty();

  @override
  void initState() {
    super.initState();
    widget.controller.onSyncService
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getCovidStatistics();
  }

  void _getCovidStatistics() async {
    var newStateList = await widget.controller.getCovidStatistics();
    setState(() {
      stateList = newStateList;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : stateList.length <=0? Text('กรุณารอสักครู่')
      :Column(
          children: [
             Text('ข้อมูลวันที่ ${stateList.first.txn_date}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),),
            //1
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15,left: 15,bottom: 5,top: 20),
                  padding: const EdgeInsets.only(right: 15,left: 15),
                  height: 145.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'จำนวนผู้ติดเชื้อรายใหม่',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        intl.NumberFormat.decimalPattern().format(stateList.first.new_case).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'สะสม',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(width: 5,),
                          Text(
                            intl.NumberFormat.decimalPattern().format(stateList.first.total_case).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                      
                    ],
                  ),
                ),
              ],
            ),
            //2
            Row(
              children: [
                Container(
                  margin:  EdgeInsets.only(left: 14,right: 2),
                  padding:  EdgeInsets.only(left: 14,right: 2),
                  height: 90.0,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ในประเทศ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        intl.NumberFormat.decimalPattern().format(stateList.first.new_case_excludeabroad).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:  EdgeInsets.only(right: 14,left: 2),
                  padding: EdgeInsets.only(right: 14,left: 2),
                  height: 90.0,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'สะสม',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        intl.NumberFormat.decimalPattern().format(stateList.first.total_case_excludeabroad).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //3
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15,left: 15,bottom: 5,top: 9),
                  padding: const EdgeInsets.only(right: 15,left: 15),
                  height: 140.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: iGreyColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'จำนวนผู้เสียชีวิตรายใหม่',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        intl.NumberFormat.decimalPattern().format(stateList.first.new_death).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'สะสม',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(width: 5,),
                          Text(
                            intl.NumberFormat.decimalPattern().format(stateList.first.total_death).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                      
                    ],
                  ),
                ),
              ],
            ),
            //4
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15,left: 15,bottom: 5,top: 7),
                  padding: const EdgeInsets.only(right: 15,left: 15),
                  height: 140.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'รักษาหาย',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        intl.NumberFormat.decimalPattern().format(stateList.first.new_recovered).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'สะสม',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(width: 5,),
                          Text(
                            intl.NumberFormat.decimalPattern().format(stateList.first.total_recovered).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                      
                    ],
                  ),
                ),
              ],
            ),
            Text('อัพเดตล่าสุด : ${stateList.first.update_date}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),)
          ],
        );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iBlueColor,
        appBar: AppBar(
          title: Text(
            'สถานการณ์ผู้ติดเชื้อ COVID-19 อัพเดทรายวัน',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: iWhiteColor),
          ),
          backgroundColor: iBlueColor,
          elevation: 0.0,
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
        body: Center(
          child: body,
        )
    );
  }
}
