import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String displayName;

  FirebaseUser _user;
  bool isSignedIn = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      setState(() {
        this._user = firebaseUser;
        this.isSignedIn = true;
        this.displayName = _user.displayName;
      });
    }
    // print(this._user);
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Center(
          child: !isSignedIn
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(50.0),
                      child: Image(
                        image: AssetImage("assets/logo.png"),
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(50.0),
                      child: Text(
                        "Hello $displayName, you are logged in as ${_user.email}",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        onPressed: signOut,
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
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
