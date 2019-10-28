import 'package:flutter/material.dart';
import 'package:mydb_todo/Note.dart';
import 'package:mydb_todo/db_helper.dart';
import 'package:mydb_todo/note_model.dart';

import 'note_details.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LCO ToDo'),
        backgroundColor: Colors.purple,
      ),
      body: ToDoListWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          navigateToDetail(
            Note("", "", 2),
            "Add Note",
          );
        },
      ),
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NoteDetail(note, title);
        },
      ),
    );

    if (result == true) {
      // Update the view
    }
  }
}

class ToDoListWidget extends StatefulWidget {
  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  DBHelper dbHelper = new DBHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getAllNotes(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<NoteModel> notesList = snapShot.data;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: notesList == null ? 0 : notesList.length,
            itemBuilder: (BuildContext context, int index) {
              NoteModel note = notesList[index];
              //TODO: Implement the new DB Helper in the note details screen
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.desc),
                leading: Icon(Icons.note),
                trailing: Icon(Icons.arrow_right),
              );
            },
          );
        }
        return new CircularProgressIndicator();
      },
    );
  }
}
