import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.amber,
            textTheme: TextTheme(
              bodyText2: TextStyle(color: Colors.purple)
            )
            ),
        //home: MyHomePage(title: 'Ronachai Pop Cate'),
        initialRoute: '/fourth',
        routes: <String, WidgetBuilder>{
          '/first': (context)=> FirstPage(),
          '/second': (context)=> SecondPage(),
          '/third': (context)=> ThirdPage(),
          '/fourth' :(context)=> FourthPage(),
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

class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
          IconButton(onPressed: (){}, icon: Icon(Icons.agriculture)),
          IconButton(onPressed: (){}, icon: Icon(Icons.bus_alert)),
          IconButton(onPressed: (){}, icon: Icon(Icons.medication)),
          IconButton(onPressed: (){}, icon: Icon(Icons.food_bank)),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.build_sharp),
        onPressed: () {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Here is the formatted by theme data'),
            Table(
            children: [
              TableRow(
               children:[
                 Container(
                   child: Center(child: Text('No')),
                   decoration:  BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0)
                   ),
                 ),
                  Container(
                   child: Center(child: Text('Name')),
                   decoration:  BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0)
                   ),
                 ),
                  Container(
                   child: Center(child: Text('Gender')),
                   decoration:  BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0)
                   ),
                 ),
               ]
              ),
               TableRow(
               children:[
                 Text('1'),
                 Text('Ronachai'),
                 Text('Male'),
               ]
              ),
               TableRow(
               children:[
                 Text('2'),
                 Text('Panita'),
                 Text('FeMale'),
               ]
              ),
               
            ],
          ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:Text('Third Page'),
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.cloud_outlined),
                ),
                Tab(
                  icon: Icon(Icons.beach_access_sharp),
                ),
                Tab(
                  icon: Icon(Icons.brightness_5_sharp),
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Cloud'),

            ),
            Center(
              child: Text('Umbrella'),
            ),
            Center(
              child: Text('Sunny'),
            ),
          ],
          ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'];
    final List<int> colorCodes = <int>[600,500,100];
    return Scaffold(
      appBar: AppBar(
        title: Text('List View Example'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index){
          return Container(
            height: 100,
            color: Colors.amber[colorCodes[index %3]],
            child: Center(
              child:Text('Entry ${entries[index]}'),
            ),
          );
        },
        separatorBuilder: (context,index) =>Divider(),
      ),
    );
  }
}