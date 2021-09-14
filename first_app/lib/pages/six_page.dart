import 'package:flutter/material.dart';

class SixPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Form'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formkey = GlobalKey<FormState>();
  String? _first_name;
  String? _last_name;
  int? _age=0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your firstname',
              icon: Icon(Icons.business),
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter firstname';
              }
              return null;
            },
            onSaved: (value){
              _first_name = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your lastname',
              icon: Icon(Icons.family_restroom),
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter last';
              }
              return null;
            },
             onSaved: (value){
               _last_name = value;
             },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your age',
              icon: Icon(Icons.ring_volume),
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter age';
              }
              if(int.parse(value) < 18){
                return 'Please enter valid age';
              }
              return null;
            },
             onSaved: (value){
               _age = int.parse(value!);
             },
          ),
          ElevatedButton(
            onPressed: (){
              if(_formkey.currentState!.validate()){
                _formkey.currentState!.save();//การเอาค่าไปใส่ในตัวแปรที่เก็บไว้

                var response = 'Hoorayyyy = $_first_name $_last_name $_age';
                Navigator.pop(context,response);
              }
            },
            child: Text('Validate'),
          ),
        ],
      ),
    );
  }
}