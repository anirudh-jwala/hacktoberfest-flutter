import 'package:flutter/material.dart';
import 'package:mydb_todo/database_helper.dart';
import 'package:mydb_todo/util.dart';
import 'note_details.dart';
import 'package:mydb_todo/Note.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Note>> getNoteList() async {
    List<Note> noteList = await databaseHelper.getNoteList();
    return noteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LCO ToDo'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<Note>>(
          future: getNoteList(), //Get the list of notes
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasData) {
              List<Note> noteList = snapshot.data;

              //No notes yet
              if (noteList.isEmpty) {
                return Center(
                  child: Text('Add notes by tapping on the + button'),
                );
              }

              return ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (BuildContext context, int index) {
                  Note note = noteList.elementAt(index);
                  String noteTitle = note.title;
                  String noteDescription = note.description;
                  String noteDate = note.date;
                  int notePriorityAsInt = note.priority;
                  String notePriorityAsString =
                      Util.getPrioritiyAsString(notePriorityAsInt);

                  return ListTile(
                    title: Text(noteTitle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        noteDescription != null
                            ? Text(noteDescription)
                            : SizedBox
                                .shrink(), //Display nothing if descripion is null
                        Text(
                          noteDate,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(notePriorityAsString),
                  );
                },
              );
            } else {
              //snapshot has no data which means it is still loading
              //so show a loader
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
      setState(() {});
    }
  }
}
