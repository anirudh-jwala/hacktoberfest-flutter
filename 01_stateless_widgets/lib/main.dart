import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
   title: 'Samkit Jain',
   debugShowCheckedModeBanner: false,
   home: Scaffold(
     key: key,
     appBar: AppBar(
       title: Text('App Bar Title'),
     ),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Text('I am text line one'),
           Text('I am line two'),
           RaisedButton(
             onPressed: () {},
             child: Text('Login'),
             color: Colors.green,
             disabledColor: Colors.red,
             elevation: 25.0,
             textColor: Colors.white,
             padding: EdgeInsets.fromLTRB(40.0, 18.0, 40.0, 18.0),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(28.0)
             ),
             splashColor: Colors.blue,
           ),
         ],
       ),
     ),
     floatingActionButton: FloatingActionButton.extended(
       onPressed: () {},
       icon: Icon(Icons.photo_camera),
       label: Text('Smile'),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(35.0)),
       ),
     ),
   ),
 );
 }
}
