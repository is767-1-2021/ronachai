import 'package:flutter/material.dart';

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