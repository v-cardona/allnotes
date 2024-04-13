import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:allnotes/data/core/firebase_client.dart';
import 'package:allnotes/data/models/note_model.dart';

abstract class NotesRemoteDataSource {
  /// create note
  Future<NoteModel> createNote(String userId, NoteModel note);

  /// get all notes
  Future<List<NoteModel>> getAllNotes(String userId);
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

  @override
  Future<List<NoteModel>> getAllNotes(String userId) async {
    QuerySnapshot<Object?> querySnapshot =
        await _client.getAllDocuments(_getCollectionName(userId));
    return querySnapshot.docs.map((e) {
      NoteModel model = e.data() as NoteModel;
      return model.copyWith(
        id: e.id,
      );
    }).toList();
  }
}
