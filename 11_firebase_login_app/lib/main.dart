import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SigninPage.dart';
import 'SignupPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/SigninPage': (BuildContext context) => SigninPage(),
        '/SignupPage': (BuildContext context) => SignupPage(),
      },
    );
  }
}
