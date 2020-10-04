import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:firebaselogin/model/contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _email = '';
  String _address = '';
  String _photoUrl = "empty";

  saveContact(BuildContext context) async {
    if (_firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _phone.isNotEmpty &&
        _email.isNotEmpty &&
        _address.isNotEmpty) {
      Contact contact = Contact(this._firstName, this._lastName, this._phone,
          this._email, this._address, this._photoUrl);

      await _databaseReference.push().set(contact.toJson());

      navigateToLastScreen(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Field Required'),
            content: Text('All fields are required'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future pickImage() async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 200.0,
      maxWidth: 200.0,
    );

    File file = File(pickedFile.path);

    String fileName = basename(file.path);
    uploadImage(file, fileName);
  }

  void uploadImage(File file, String fileName) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);

    storageReference.putFile(file).onComplete.then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();

      setState(() {
        _photoUrl = downloadUrl;
      });
    });
  }

  navigateToLastScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    this.pickImage();
                  },
                  child: Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _photoUrl == "empty"
                              ? AssetImage('assets/logo.png')
                              : NetworkImage(_photoUrl),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // First Name
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _firstName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              // Last Name
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              // Phone
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _phone = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              // Email
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              // Address
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              // Save
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  color: Colors.red,
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                  onPressed: () {
                    saveContact(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
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
