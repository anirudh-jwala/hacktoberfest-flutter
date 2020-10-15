import 'dart:developer';

import 'package:api_flutter/models/api_response.dart';
import 'package:api_flutter/models/note_for_listing.dart';
import 'package:api_flutter/services/notes_service.dart';
import 'package:api_flutter/views/note_delete.dart';
import 'package:api_flutter/views/note_modify.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();
  List<NoteForListing> notes = [];
  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()));
        },
        child: Icon(Icons.add),
      ),
      body: Builder(builder: (_) {
        
        if (_isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if(_apiResponse.error) {
          return Center(child: Text(_apiResponse.errorMsg));
        }

        return ListView.separated(
          itemCount: notes.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1.0, color: Colors.orange),
          itemBuilder: (_, __) {
            return Dismissible(
              key: ValueKey(_apiResponse.data[__].noteID),
              child: ListTile(
                title: Text(_apiResponse.data[__].noteTitle),
                subtitle: Text(
                    'Last edited on ${formatDateTime(_apiResponse.data[__].latestEditDateTime)}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NoteModify(noteID: _apiResponse.data[__].noteID)));
                },
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16),
                child: Align(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft),
              ),
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (_) => NoteDelete());
                print(result);
                return result;
              },
            );
          },
        );
      }),
    );
  }
}
