import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:notekeeperapp/models/note.dart';
import 'package:flutter/painting.dart';


class ViewNote extends StatefulWidget {
  final Note note ;
  ViewNote(this.note);
  @override
  _ViewNoteState createState() => _ViewNoteState(this.note);
}

class _ViewNoteState extends State<ViewNote> {
  final Note note;

  @override

  _ViewNoteState(this.note);
  Widget build(BuildContext context) {
    debugPrint(note.title); //for debugging
    debugPrint(note.desc); //for debugging
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('View note',style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'JosefinSans',
        ),),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            GestureDetector(
              child: Container(
                  padding:EdgeInsets.fromLTRB(30, 40, 30, 20)
                  ,child: Text(note.title,style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                fontFamily: 'JosefinSans',
              ),)),
              onTap: (){
                _goToDesc();
              },
            ),
            GestureDetector(
              child: Container(
                  padding:EdgeInsets.fromLTRB(30, 50, 30, 20)
                  ,child: Text(note.desc!=null ? note.desc:'No description.',style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700
              ),
              )
              ),
              onTap: (){
                _goToDesc();
              },
            )
          ],
        ),
      ),
    );
  }
  void _goToDesc() async {

    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoteDesc(note, 'Edit Note')));
    if(result!=null){
      Navigator.pop(context);
    }
  }


}
