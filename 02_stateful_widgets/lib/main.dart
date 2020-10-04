import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int counter = 1;

  List<String> spanishNumbers = [
    "Uno",
    "Dos",
    "Tres",
    "Cuatro",
    "Cinco",
    "Seis",
    "Seite",
    "Ocho",
    "Nueve",
    "Dietz"
  ];

  List<String> englishNumbers = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten"
  ];

  String defaultSpanishText = "Spanish Numbers";
  String defaultEnglishText = "English Numbers";

  void incrementNumbers() {
    setState(() {
      if (counter <= 9) {
        counter = counter + 1;
      } else {
        counter = 0;
      }

      print(counter + 1);
      defaultSpanishText = spanishNumbers[counter];
      defaultEnglishText = englishNumbers[counter];
    });
  }

  void decrementNumbers() {
    setState(() {
      print(counter);
      if (counter == 0) {
        counter = 9;
      } else {
        counter = counter - 1;
      }

      defaultSpanishText = spanishNumbers[counter];
      defaultEnglishText = englishNumbers[counter];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Spanish Numbers"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                defaultSpanishText,
                style: TextStyle(
                  fontSize: 34.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
              ),
              Text(
                defaultEnglishText,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.all(12.0),
                    onPressed: () {
                      decrementNumbers();
                    },
                    child: Icon(Icons.remove),
                    elevation: 14.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.red,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(12.0),
                    onPressed: () {
                      incrementNumbers();
                    },
                    child: Icon(Icons.add),
                    elevation: 14.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
