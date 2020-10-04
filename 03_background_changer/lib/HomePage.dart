import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var colors = [
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.indigo,
  ];

  var currentBackgroundColor = Colors.red;
  var currentButtonColor = Colors.blue;

  void setRandomColor() {
    var randomNumber1 = Random().nextInt(colors.length);
    var randomNumber2 = Random().nextInt(colors.length);

    setState(() {
      currentBackgroundColor = colors[randomNumber1];
      currentButtonColor = colors[randomNumber2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentBackgroundColor,
      child: Center(
        child: RaisedButton(
          color: currentButtonColor,
          padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
          onPressed: setRandomColor,
          child: Text(
            'Suprise!',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 20.0,
        ),
      ),
    );
  }
}
