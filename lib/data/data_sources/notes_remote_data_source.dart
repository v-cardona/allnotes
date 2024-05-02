import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:allnotes/common/constants/notes_constants.dart';
import 'package:allnotes/data/core/firebase_client.dart';
import 'package:allnotes/data/models/note_model.dart';

abstract class NotesRemoteDataSource {
  /// create note
  Future<NoteModel> createNote(String userId, NoteModel note);

  /// edit note
  Future<bool> editNote(String userId, NoteModel note);

  /// get all notes
  Future<List<NoteModel>> getAllNotes(String userId);

  /// get unspecified
  Future<List<NoteModel>> getUnspecifiedNotes(String userId);
}

class NotesRemoteDataSourceImpl extends NotesRemoteDataSource {
  final String notes = 'notes';

  final FirebaseClient _client;

  NotesRemoteDataSourceImpl(this._client);

  String _getCollectionName(String userId) {
    return '$notes-$userId';
  }

  List<NoteModel> _queryToListNote(QuerySnapshot<Object?> querySnapshot) {
    return querySnapshot.docs.map((e) {
      NoteModel model = e.data() as NoteModel;
      return model.copyWith(
        id: e.id,
      );
    }).toList();
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
  Future<bool> editNote(String userId, NoteModel note) async {
    CollectionReference collection =
        _client.getCollection(_getCollectionName(userId));
    bool edited = false;
    await collection.doc(note.id).set(note).then(
          (value) => edited = true,
        );
    return edited;
  }

  @override
  Future<List<NoteModel>> getAllNotes(String userId) async {
    QuerySnapshot<Object?> querySnapshot =
        await _client.getAllDocuments(_getCollectionName(userId));
    return _queryToListNote(querySnapshot);
  }

  @override
  Future<List<NoteModel>> getUnspecifiedNotes(String userId) async {
    final collection = _client.getCollection(_getCollectionName(userId));
    QuerySnapshot<Object?> querySnapshot = await collection
        .where(
          NoteConstants.statusStr,
          isEqualTo: NoteState.unspecified.index,
        )
        .orderBy(
          NoteConstants.createdAtStr,
          descending: true,
        )
        .get();
    return _queryToListNote(querySnapshot);
  }
}
