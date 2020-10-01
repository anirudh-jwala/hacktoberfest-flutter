import 'package:flutter/material.dart';
import 'screens/note_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ToDos',textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
          backgroundColor: Colors.transparent,
                elevation: 0.0,
     ),
      home: NoteList(),
    )
      );
  }
}
