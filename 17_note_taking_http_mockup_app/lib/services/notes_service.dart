import 'dart:convert';

import 'package:api_flutter/models/api_response.dart';
import 'package:api_flutter/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const url = 'http://demo5721931.mockable.io/a';

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(url).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createdDateTime']),
            latestEditDateTime: item['latestEditDateTime'] != null
                ? DateTime.parse(item['latestEditDateTime'])
                : null,
          );
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMsg: 'An error has occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMsg: 'An error occured'));
  }
}

// return [
//       NoteForListing(
//           noteID: "1",
//           noteTitle: "Note 1",
//           createDateTime: DateTime.now(),
//           latestEditDateTime: DateTime.now()),
//       NoteForListing(
//           noteID: "2",
//           noteTitle: "Note 2",
//           createDateTime: DateTime.now(),
//           latestEditDateTime: DateTime.now()),
//       NoteForListing(
//           noteID: "3",
//           noteTitle: "Note 3",
//           createDateTime: DateTime.now(),
//           latestEditDateTime: DateTime.now()),
//      ];
