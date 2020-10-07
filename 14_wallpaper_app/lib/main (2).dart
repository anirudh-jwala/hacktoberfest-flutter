import 'package:flutter/material.dart';
import 'package:wallpaper/home.dart';

void main() {
  runApp(MyApp());
}

// Dont forget to add your apikey in data.dart file
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff303030)),
      home: Home(),
    );
  }
}
