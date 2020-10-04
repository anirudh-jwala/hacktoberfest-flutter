import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'Note.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // Singleton
  static DatabaseHelper _databaseHelper;

  // Singleton
  static Database _database;

  // Strings that we will be using to store into the Database
  String noteTable = 'note_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  // Custom getter

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $noteTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = await db.delete(noteTable, where: "$colID = $id");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();

    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for (var i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
