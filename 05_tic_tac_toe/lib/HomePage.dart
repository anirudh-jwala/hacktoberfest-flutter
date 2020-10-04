import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO(1): Link up images from the asset folder

  AssetImage circle = AssetImage('images/circle.png');
  AssetImage cross = AssetImage('images/cross.png');
  AssetImage edit = AssetImage('images/edit.png');

  // * Other initialization parameters

  bool isCross = true; // This will indicate the input being given by the user
  // if it is true then the user gave cross as input, else O is the input

  String message; // String showing the winner message

  List<String>
      gameState; // Decide the state in the 9x9 grid whether it is cross, circle, empty

  // TODO(2): Initialize the state of the box/grid/matrix (gameState) and winner message with empty values

  @override
  void initState() {
    super.initState();

    this.gameState = [
      "empty",
      "empty",
      "empty",
      "empty",
      "empty",
      "empty",
      "empty",
      "empty",
      "empty",
    ];

    this.message = "";
  }

  // TODO(3): playGame Method - input box values are set when someone clicks

  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = "cross";
        } else {
          this.gameState[index] = "circle";
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  // TODO(4): resetGame Method - getting the initial state (rather than restarting the app)

  resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty"
      ];

      this.message = "";
    });
  }

  // TODO(5): getImage method

  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
    }
  }

  // TODO(6): check for win logic - Actual Tic Tac Toe logic

  checkWin() {
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins! 🎉';
      });
    } else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        this.message = '${this.gameState[3]} Wins! 🎉';
      });
    } else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[6]} Wins! 🎉';
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins! 🎉';
      });
    } else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        this.message = '${this.gameState[1]} Wins! 🎉';
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[2]} Wins! 🎉';
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins! 🎉';
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[2]} Wins! 🎉';
      });
    } else if (!gameState.contains("empty")) {
      setState(() {
        this.message = 'Game Draw 💁‍';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(14.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.red,
            minWidth: 200.0,
            height: 40.0,
            elevation: 20.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              "Reset Game",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              this.resetGame();
            },
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Text(
              "LearnCodeOnline.in",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: Text(
              "A Project by Anirudh 🔥",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
