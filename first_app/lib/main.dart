import 'package:first_app/models/first_form_model.dart';
import 'package:first_app/pages/seventh_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/eighth_page.dart';
import 'pages/fifth_page.dart';
import 'pages/first_page.dart';
import 'pages/fourth_page.dart';
import 'pages/second_page.dart';
import 'pages/six_page.dart';
import 'pages/third_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(
          create: (context) => FirstFormModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.yellow,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.purple)
        )
        ),
    //home: MyHomePage(title: 'Ronachai Pop Cate'),
    initialRoute: '/5',
    routes: <String, WidgetBuilder>{
      '/1': (context)=> FirstPage(),
      '/2': (context)=> SecondPage(),
      '/3': (context)=> ThirdPage(),
      '/4' :(context)=> FourthPage(),
      '/5' :(context)=> FifthPage(),
      '/6' :(context)=> SixPage(),
      '/7' :(context)=> SeventhPage(),
      '/8' :(context)=> EighthPage(),
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Image cat = Image.asset(
    'assets/popcat2.png',
    width: 120,
  );

  Image cat1 = Image.asset(
    'assets/popcat1.png',
    width: 120,
  );
  Image cat2 = Image.asset(
    'assets/popcat2.png',
    width: 120,
  );

  void _incrementCounter() {
    setState(() {
      cat = cat2;
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      cat = cat1;
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              margin: EdgeInsets.only(left: 100.0, right: 100.0, bottom: 50.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: cat,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: _decrementCounter,
                    child: Text('Decrease')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: _incrementCounter,
                    child: Text('Increase'))
              ],
            ),
            //SubmitButton("ปุ่มแรกของฉัน"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String buttonText;
  SubmitButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(this.buttonText),
      onPressed: () {
        print('Presssing');
      },
    );
  }
}