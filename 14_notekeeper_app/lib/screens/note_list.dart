import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:notekeeperapp/utils/database_helper.dart';
import 'package:notekeeperapp/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:notekeeperapp/screens/about.dart';
import 'package:notekeeperapp/screens/view_note.dart';
import 'package:ant_icons/ant_icons.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count=0;
  List<Note> noteList;
  var random = Random();
  @override
  Widget build(BuildContext context) {
    if (noteList == null){
      noteList = List<Note>();
      updateListView();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(7,13,0,4),
          child: Text('Notekeeper',style: TextStyle(
            fontSize: 30,
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
            letterSpacing: 1.5,
          ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,6,3,7),
            child: IconButton(icon: Icon(Icons.info,color: Theme.of(context).primaryColorDark),
            iconSize: 32,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutApp()));
            },),
          )
        ],
      ),
      body: noteList.length ==0 ?
        Container(
            color: Colors.white,
            child: Text('NOTHING TO SHOW'),
            alignment: Alignment.center ,) :
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,10),

            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                child: Container(
                  color: Colors.white,
                    child: listViewNoteList())
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        tooltip: 'Add note',
        backgroundColor: Theme.of(context).primaryColorDark,
        icon: Icon(Icons.add),
        label: Text('ADD NOTE',style: TextStyle(
          fontFamily: 'JosefinSans',
        ),),
        onPressed: (){
          gotoNoteDescription(Note('',1,''),'Add Note');
        },
      ),
    );
  }

  ListView listViewNoteList(){
    return ListView.builder(
      physics: BouncingScrollPhysics(),

        itemCount: count,
        itemBuilder: (BuildContext context, int position){
        int colorNum = random.nextInt(18);
        Color shadowColor = Colors.primaries[colorNum];
        Color noteColor = Colors.primaries[colorNum][50];

          return Container(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: noteColor, width: 1)
              ),
              shadowColor: shadowColor,
              elevation: 5,
              color: noteColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: getNoteColor(noteList[position].priority),
                  child: Icon(AntIcons.right_circle_outline),
                ),
                trailing: GestureDetector(
                    child: Icon(Icons.delete_outline),
                        onTap: (){
                      _deleteNote(context,noteList[position]);

                  },
                ),
                title: Text(noteList[position].title,style: TextStyle(fontFamily: 'JosefinSans',),),
                subtitle: Text(noteList[position].date,style: TextStyle(fontFamily: 'JosefinSans',),),
                onTap: () async {
                  await gotoViewNote(noteList[position]);
                  updateListView();

                },
              ),
            ),
          );
        } );
  }
  void gotoNoteDescription(Note note,String title) async {
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context)=> NoteDesc(note,title)));
    if(result ==true)//not necessary to add a bool check.We'll need to update the listview nevertheless after popping the detail page.
    {
      updateListView();
    }
  }

  void gotoViewNote(Note note) async {
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewNote(note)));
    if(result ==true){//not necessary to add a bool check.We'll need to update the listview nevertheless after popping the detail page.
      updateListView();}
  }


  /*void updateListView() async {
    var db = await databaseHelper.database;
    List<Note> noteList = await databaseHelper.getNoteList();
    setState(() {
      this.noteList=noteList;
      this.count=noteList.length;
    });
  }*/
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDb();
    dbFuture.then((database) {
      var noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  Color getNoteColor(int priority){
    var color;
    switch(priority){
      case 0:
        color= Colors.blue;
        break;
      case 1:
        color=Colors.green;
        break;
      case 2:
        color = Colors.redAccent;
        break;
    }
    return color;
  }


  void _deleteNote(BuildContext context,Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if(result != null){
      _showSnackBar(context,'Note deleted successfully');
      updateListView();

    }
    else{
      _showSnackBar(context,'Error deleting note');
    }
  }

  void _showSnackBar(BuildContext context,String message){
    final snackBar = SnackBar(content: Text(message),
            behavior: SnackBarBehavior.fixed,
            duration: Duration(milliseconds: 700),
            backgroundColor: Colors.black54,);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  BoxShadow buildBoxShadow(Color color, BuildContext context) {

    return BoxShadow(
        color:  color.withAlpha(60),
        blurRadius: 10,
        offset: Offset(0, 8));
  }


}

