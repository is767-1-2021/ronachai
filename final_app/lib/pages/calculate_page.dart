import 'dart:math';
import 'package:final_app/controllers/calculator_controller.dart';
import 'package:final_app/models/calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'history_page.dart';

class CalculatorPage extends StatefulWidget {
  final CalculatorController controller;
  final String title;
  CalculatorPage({required this.controller, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//สามารถใช้งานได้ทุกปุ่มนะครับ ผมทำทั้ง History และ Memory ครับ'
class _MyHomePageState extends State<CalculatorPage> {
  List<Calculator> historyList = List.empty();
  bool isLoading = false;
  String _history = "0";
  String _result = "0";
  String _memoryKey = "0";
  String _memory = "0";
  String _expression = "";
  double _equationFontSize = 30.0;
  double _resultFontSize = 40.0;

  onPressedButton(String buttonText, BuildContext context) async {
    setState(() {
      if (buttonText == "√") {
        _result = '${sqrt(int.parse(_history))}';
      } else if (buttonText == "x²") {
        _result = '${pow(int.parse(_history),2)}';
      } else if (buttonText == "1/x") {
        _result = '${1/int.parse(_history)}';
      } else if (buttonText == "MC") {
        _memory = "0";
        _memoryKey = "0";
        _result = "0";
        _history = "0";
      } else if (buttonText == "MR") {
        _memoryKey = _result;
      } else if (buttonText == "M+") {
        try {
          if (_memoryKey == "0") {
            _memoryKey = _history;
          }
          _history = "";
          _expression = _result + "+" + _memoryKey;
          _expression = _expression.replaceAll('×', '*');
          _expression = _expression.replaceAll('÷', '/');
          Parser parser = new Parser();
          Expression expression = parser.parse(_expression);
          ContextModel cm = ContextModel();
          _result = NumberFormat("#,###").format(expression.evaluate(EvaluationType.REAL, cm));
          _memory = _result;
        } catch (e) {
          _result = "Error";
        }
      } else if (buttonText == "M-") {
        try {
          if (_memoryKey == "0") {
            _memoryKey = _history;
          }
          _history = "";
          _expression = _result + "-" + _memoryKey;
          _expression = _expression.replaceAll('×', '*');
          _expression = _expression.replaceAll('÷', '/');
          Parser parser = new Parser();
          Expression expression = parser.parse(_expression);
          ContextModel cm = ContextModel();
          _result = NumberFormat("#,###").format(expression.evaluate(EvaluationType.REAL, cm));
          _memory = _result;
        } catch (e) {
          _result = "Error";
        }
      } else if (buttonText == "C") {
        _history = "0";
        _result = "0";
      } else if (buttonText == "CE") {
        _history = "0";
      } else if (buttonText == "⌫") {
        _history = _history.length > 0
            ? _history.substring(0, _history.length - 1)
            : _history;
        if (_history == "") {
          _history = "0";
        }
      } else if (buttonText == "=") {
        _expression = _history;
        _expression = _expression.replaceAll('×', '*');
        _expression = _expression.replaceAll('÷', '/');

        try {
          Parser parser = new Parser();
          Expression expression = parser.parse(_expression);
          ContextModel cm = ContextModel();
          _result = '${expression.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          _result = "Error";
        }
      } else {
        if (_history == "0") {
          _history = buttonText;
        } else {
          //_history =NumberFormat("#,###").format(int.parse(_history.replaceAll(',', '')));
          _history = _history + buttonText;
          _memoryKey = _history;
        }
      }
    });

    if (buttonText == "=") {
      //add to firestore Database
      await widget.controller.addHistory(_history + "=", _result);
      // add to provider
      context.read<CalculatorModel>().historyList!.add(new Calculator(_history + "=", _result, DateTime.now()));
      //Sort desc in list
      historyList.sort((a, b) => b.createDate.compareTo(a.createDate));
    }
  }

  Widget buildKeyButton(String buttonText, double buttonHeight, Color buttonColor,
      BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.blueGrey, width: 1, style: BorderStyle.solid)),
        ),
        onPressed: () => onPressedButton(buttonText, context),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  //get data from firestore Database on Load app.
  void _getHistory() async {
    var newHistoryList = await widget.controller.fetchHistory();
    setState(() {
      historyList = newHistoryList;
    });
    context.read<CalculatorModel>().historyList = newHistoryList;
  }

 //Show Dialog - History
  Widget showHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 180,
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
    );
  }

  //Show Dialog - Memory
  Widget showMemory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Text(
            _memory,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller.onSync.listen((bool syncState) => setState(() => isLoading = syncState));
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryPage()));
              },
              icon: Icon(Icons.history)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('History'),
                        content: showHistory(),
                      );
                    });
              },
              icon: Icon(Icons.history)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Memory'),
                        content: showMemory(),
                      );
                    });
              },
              icon: Icon(Icons.memory)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                _history,
                style: TextStyle(fontSize: _equationFontSize, color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 25),
              child: Text(
                _result,
                style: TextStyle(fontSize: _resultFontSize),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildKeyButton("√", 1, Colors.blueGrey.shade300, context),
                        buildKeyButton("x²", 1, Colors.blueGrey.shade300, context),
                        buildKeyButton("1/x", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("MC", 1, Colors.blueGrey.shade300, context),
                        buildKeyButton("MR", 1, Colors.blueGrey.shade300, context),
                        buildKeyButton("M+", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("C", 1, Colors.blueGrey.shade300, context),
                        buildKeyButton("CE", 1, Colors.blueGrey.shade300, context),
                        buildKeyButton("⌫", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("7", 1, Colors.black54, context),
                        buildKeyButton("8", 1, Colors.black54, context),
                        buildKeyButton("9", 1, Colors.black54, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("4", 1, Colors.black54, context),
                        buildKeyButton("5", 1, Colors.black54, context),
                        buildKeyButton("6", 1, Colors.black54, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("1", 1, Colors.black54, context),
                        buildKeyButton("2", 1, Colors.black54, context),
                        buildKeyButton("3", 1, Colors.black54, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton(".", 1, Colors.black54, context),
                        buildKeyButton("0", 1, Colors.black54, context),
                        buildKeyButton("00", 1, Colors.black54, context),
                      ])
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildKeyButton("", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("M-", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("+", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("-", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("×", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("÷", 1, Colors.blueGrey.shade300, context),
                      ]),
                      TableRow(children: [
                        buildKeyButton("=", 1, Colors.blueGrey.shade300, context),
                      ])
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}