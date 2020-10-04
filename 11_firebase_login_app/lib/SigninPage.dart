import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSignupScreen() {
    Navigator.pushReplacementNamed(context, "/SignupPage");
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  void signin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        AuthResult user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
      }
    }
  }

  showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Email
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an email';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) {
                            _email = input;
                          },
                        ),
                      ),
                      // Password
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be 6 char atleast';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) {
                            _password = input;
                          },
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                        child: RaisedButton(
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: signin,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      // Redirect to signup page
                      GestureDetector(
                        onTap: navigateToSignupScreen,
                        child: Text(
                          'Create an Account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
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
