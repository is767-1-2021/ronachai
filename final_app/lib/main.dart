import 'package:final_app/models/calculator_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/calculator_controller.dart';
import 'pages/calculate_page.dart';
import 'services/calculator_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var services = FirebaseServices();
  var controller = CalculatorController(services);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CalculatorModel(),
        ),
      ],
      child: MyApp(
        controller: controller,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final CalculatorController controller;
  MyApp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CalculatorPage(controller: controller, title: 'Calculator'),
    );
  }
}


