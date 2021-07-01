import 'package:flutter/material.dart';
import 'package:test_xaner/screens/main_screen.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: kAppBackgroundColour,
      ),
      home: MainScreen(),
    );
  }
}

