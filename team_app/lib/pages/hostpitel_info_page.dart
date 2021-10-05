import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/models/HospitelFormModel.dart';

import 'package:provider/provider.dart';

import 'login_page.dart';



class HostpitelInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('เพิ่มข้อมูลโรงพยาบาล'),
          backgroundColor: iBlueColor,
          actions: [
            IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
          ],
      ),
      body: HostpitelInfoState(),
    );
  }
}

class HostpitelInfoState extends StatefulWidget {
  @override
  _HostpitelInfoState createState() => _HostpitelInfoState();
}

class _HostpitelInfoState extends State<HostpitelInfoState> {
  final _formKey = GlobalKey<FormState>();
  String? _hospitalName;
  String? _addressName;
  int? _phoneNumber;
  int? _numberPatient;
  int? _numberStaff;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ใส่ชื่อ Hospitel',
                icon: Icon(Icons.business),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ใส่ชื่อ Hospitel';
                }
    
                return null;
              },
              onSaved: (value) {
                _hospitalName = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ใส่ที่อยู่Hospitel',
                icon: Icon(Icons.home_filled),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาใส่ที่อยู่Hospitel.';
                }
    
                return null;
              },
              onSaved: (value) {
                _addressName = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ใส่เบอร์โทรHospitel',
                icon: Icon(Icons.ring_volume),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาใส่เบอร์Hospitel';
                }
                return null;
              },
              onSaved: (value) {
                _phoneNumber = int.parse(value!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ใส่จำนวนคนไข้ที่รองรับได้',
                icon: Icon(Icons.people_rounded),
              ),
              keyboardType:TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาใส่จำนวนคนไข้ที่รองรับได้';
                }
                return null;
              },
              onSaved: (value) {
                _numberPatient = int.parse(value!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ใส่จำนวนเจ้าหน้าที่ที่ปฎิบัตรงาน',
                icon: Icon(Icons.people),
              ),
              keyboardType:TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาใส่จำนวนเจ้าหน้าที่ที่ปฎิบัตรงาน';
                }
                return null;
              },
              onSaved: (value) {
                _numberStaff = int.parse(value!);
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      if (_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
    
                        context.read<HospitelFormModel>().hospitelName=_hospitalName;
                        context.read<HospitelFormModel>().addressName=_addressName;
                        context.read<HospitelFormModel>().phoneNumber=_phoneNumber;
                        context.read<HospitelFormModel>().numberPatient=_numberPatient;
                        context.read<HospitelFormModel>().numberStaff=_numberStaff;
    
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text('เพิ่ม'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Text('ล้างข้อมูล'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}