import 'package:final_app/models/calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
 List<Calculator> historyList = List.empty();

  @override
  Widget build(BuildContext context) {
    historyList = context.read<CalculatorModel>().historyList!;
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body:SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: historyList.isEmpty ? 1 : historyList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (historyList.isEmpty) {
                    return Center(child: Text('ไม่พบประวัติ'));
                  }
                  return ListTile(
                    title: Text(
                      historyList[index].historyValue,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      historyList[index].resultValue,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  );
                }),
          ),
        ],
          ),
      ));
  }
}