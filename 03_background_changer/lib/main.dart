import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Background Changer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Background'),
        ),
        body: HomePage(),
      ),
    );
  }
}