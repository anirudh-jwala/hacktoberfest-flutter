import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'note_model.dart';

class DBHelper {

  // Singleton
  Database _database;

  String noteTable = 'note_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  Future<void> openDB() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) {
          return db.execute(
            """CREATE TABLE $noteTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,
    $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)""",
          );
        },
        version: 1,
      );
    }
  }

  Future<void> insertNotes(NoteModel noteModel) async {
    await openDB();
    await _database.insert(
      'notes',
      noteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database.query('notes');
    return List.generate(maps.length, (i) {
      return NoteModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        desc: maps[i]['desc'],
        priority: maps[i]['priority'],
      );
    });
  }

  Future<void> updateNote(NoteModel noteModel) async {
    // Get a reference to the database.
    await openDB();

    // Update the given Note.
    await _database.update(
      'notes',
      noteModel.toMap(),
      // Ensure that the Note has a matching id.
      where: "id = ?",
      // Pass the Note's id as a whereArg to prevent SQL injection.
      whereArgs: [noteModel.id],
    );
  }

  Future<void> deleteNote(int id) async {
    await openDB();
    await _database.delete(
      'notes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  var fido = NoteModel(
    id: 0,
    title: 'Todo Test',
    desc: 'This is a TODO test',
    priority: 1,
  );
}
