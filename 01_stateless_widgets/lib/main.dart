import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
   title: 'Anirudh Jwala',
   debugShowCheckedModeBanner: false,
   home: Scaffold(
     key: key,
     appBar: AppBar(
       title: Text('App Bar Title'),
     ),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Text('I am text line one'),
           Text('I am line two'),
           RaisedButton(
             onPressed: () {},
             child: Text('Login'),
             color: Colors.orange,
             disabledColor: Colors.grey,
             elevation: 25.0,
             textColor: Colors.white,
             padding: EdgeInsets.fromLTRB(40.0, 18.0, 40.0, 18.0),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(28.0)
             ),
             splashColor: Colors.grey,
           ),
         ],
       ),
     ),
     floatingActionButton: FloatingActionButton.extended(
       onPressed: () {},
       icon: Icon(Icons.photo_camera),
       label: Text('Click'),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(30.0)),
       ),
     ),
   ),
 );
 }
}
