import 'package:flutter/material.dart';
import 'package:test_flutter/page/loginpage.dart';
import 'package:test_flutter/page/registrationpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage()
    );
  }
}
