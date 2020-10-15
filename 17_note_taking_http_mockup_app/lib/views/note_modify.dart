import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String noteID;
  bool get isEditing => noteID != null;

  NoteModify({this.noteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create Note')),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(decoration: InputDecoration(hintText: 'Note title')),
            SizedBox(height: 8.0),
            TextField(decoration: InputDecoration(hintText: 'Note content')),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 35.0,
              child: RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
