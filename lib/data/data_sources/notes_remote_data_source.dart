import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:allnotes/data/core/firebase_client.dart';
import 'package:allnotes/data/models/note_model.dart';

abstract class NotesRemoteDataSource {
  /// create note
  Future<NoteModel> createNote(String userId, NoteModel note);
}

class NotesRemoteDataSourceImpl extends NotesRemoteDataSource {
  final String notes = 'notes';

  final FirebaseClient _client;

  NotesRemoteDataSourceImpl(this._client);

  String _getCollectionName(String userId) {
    return '$notes-$userId';
  }

  @override
  Future<NoteModel> createNote(String userId, NoteModel note) async {
    CollectionReference collection =
        _client.getCollection(_getCollectionName(userId));
    DocumentReference noteReference = await collection.add(note);
    return note.copyWith(
      id: noteReference.id,
    );
  }
}
