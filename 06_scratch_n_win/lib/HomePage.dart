import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Todo: Import images
  AssetImage circle = AssetImage('images/circle.png');

  AssetImage lucky = AssetImage('images/rupee.png');
  
  AssetImage unlucky = AssetImage('images/sadFace.png');
  
  // Todo: get an array
  List<String> itemArray;
  int luckyNumber;
  int noOfAttempts;

  // Todo: init array with 25 elements
  @override
  void initState() {
    super.initState();

    itemArray = List<String>.generate(25, (index) => "empty");
    noOfAttempts = 0;
    generateRandomNumber();
  }

  generateRandomNumber(){
    int random = Random().nextInt(25);
    print("Random Number generated: " + random.toString());
    setState(() {
     luckyNumber = random; 
    });
  }

  // Todo: define a getImage method
  AssetImage getImage(int index){
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
      case "unlucky":
        return unlucky;
    }
    return circle;
  }

  // Todo: playGame method
  playGame(int index){
    if (luckyNumber == index) {
      setState(() {
       itemArray[index] = "lucky"; 
       _winnerSnackBar();
      });
    } else {
      checkAttempts();
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  checkAttempts(){
    if(noOfAttempts == 4){
      showAll();
      _showSnackBar();
    }
  }

  _showSnackBar(){
    showAll();
    final snackBar = SnackBar(
      content: Text('Game Over, Presented By LearnCodeOnline.in'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _winnerSnackBar(){
    final snackBar = SnackBar(
      content: Text('Wooat!! 🎉, Presented By LearnCodeOnline.in'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // Todo: show all method
  showAll() {
    noOfAttempts = 0;
    setState(() {
     itemArray = List<String>.filled(25, "unlucky");
     itemArray[luckyNumber] = "lucky"; 
    });
  }

  // Todo: reset all method
  resetGame(){
    noOfAttempts = 0;
    setState(() {
     itemArray = List<String>.filled(25, "empty"); 
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Scracth & Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(18.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  elevation: 6.0,
                  onPressed: () {
                    this.playGame(i);
                    noOfAttempts++;
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.0),
            child: RaisedButton(
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                this.showAll();
              },
              color: Colors.pink,
              child: Text(
                "Show All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
              ),
              elevation: 12.0,
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.0),
            child: RaisedButton(
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                this.resetGame();
              },
              color: Colors.pink,
              child: Text(
                "Reset",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
              ),
              elevation: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}