import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:notekeeperapp/models/note.dart';
import 'package:path_provider/path_provider.dart';



class DatabaseHelper{
  static DatabaseHelper _databaseHelper ;
  static Database _database;

  // GOTTA CHECK THIS AFTERWARDS
  String noteTable='tablename';
  String colId='id';
  String colTitle='title';
  String colDesc='desc';
  String colDate='date';
  String colPriority='priority';


  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper==null){
      _databaseHelper=DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future <Database> get database async {
    if(_database==null){
      _database = await initializeDb();
    }
    return _database;
  }


  Future <Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var db = await openDatabase(path,version: 1,onCreate: _createDb);
    return db;
  }

  void _createDb(Database db,int version) async {
    await db.execute('CREATE TABLE $noteTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT,$colDate TEXT,$colPriority INTEGER)');
  }

  //fetch

  Future <List<Map<String,dynamic>>>getNotesMapList() async {
    Database db = await this.database;
    var result = await db.query(noteTable,orderBy: '$colPriority DESC,$colId DESC');
    return result;
  }
  //insert
  Future insertNote(Note note) async {
    Database db = await this.database;
    var result = db.insert(noteTable, note.toMap());
    return result;
  }
  //delete
  //delete function might be weird//
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }
  //update
  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),where: '$colId=?',whereArgs: [note.id]);
    return result;
  }
  //count

  // this might br wrong..check later
  Future countNote() async {
    //change to int from List<Map<S,d>>//
    Database db = await this.database;
    var result = await db.rawQuery('SELECT COUNT($colId) FROM $noteTable');
    return result;
  }


  Future getNoteList() async {
    var mapList = await getNotesMapList();
    var _noteList = List<Note>() ;
    int len=mapList.length;
    for(int i=0;i<len;i++){
      _noteList.add(Note.fromMap(mapList[i]));
    }
    return _noteList;
  }


}
