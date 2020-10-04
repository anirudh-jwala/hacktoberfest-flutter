import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Only declarations

  AssetImage one = AssetImage("images/one.png");

  AssetImage two = AssetImage("images/two.png");
  
  AssetImage three = AssetImage("images/three.png");
  
  AssetImage four = AssetImage("images/four.png");
  
  AssetImage five = AssetImage("images/five.png");
  
  AssetImage six = AssetImage("images/six.png");

  AssetImage diceImage1; // Used for what you want to display
  AssetImage diceImage2;

  // Init method
  @override
  void initState() {
    // This is almost like a constructor which runs when we run the app for the first time
    super.initState();
    setState(() {
     diceImage1 = one; 
     diceImage2 = two;
    });
  }

  void rollDice(){
    int random1 = (Random().nextInt(6)) + 1;
    int random2 = (Random().nextInt(6)) + 1;
    
    AssetImage newImage1, newImage2; 

    switch (random1) {
      case 1:
        newImage1 = one;
        break;
      case 2:
        newImage1 = two;
        break;
      case 3:
        newImage1 = three;
        break;
      case 4:
        newImage1 = four;
        break;
      case 5:
        newImage1 = five;
        break;
      case 6:
        newImage1 = six;
        break;
    }

    switch (random2) {
      case 1:
        newImage2 = one;
        break;
      case 2:
        newImage2 = two;
        break;
      case 3:
        newImage2 = three;
        break;
      case 4:
        newImage2 = four;
        break;
      case 5:
        newImage2 = five;
        break;
      case 6:
        newImage2 = six;
        break;
    }

    setState(() {
     diceImage1 = newImage1; 
     diceImage2 = newImage2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image(
                    image: diceImage1,
                    width: 150.0,
                    height: 150.0,
                  ),
                  Image(
                    image: diceImage2,
                    width: 150.0,
                    height: 150.0,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  child: Text(
                    'Roll the Dice!',
                    style: TextStyle(),
                  ),
                  onPressed: (){
                    rollDice();
                  },
                  elevation: 30.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}