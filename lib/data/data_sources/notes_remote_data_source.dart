import 'package:allnotes/data/core/firestore_client.dart';
import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/data/models/note_result_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<bool> addNote(NoteModel note);
  Future<bool> updateNote(NoteModel note);
}

class NotesRemoteDataSourceImpl extends NotesRemoteDataSource {
  final FirestoreClient _client;

  NotesRemoteDataSourceImpl(this._client);

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response = await _client.getAllNotes();
    List<NoteModel> notes = NotesResultModel.fromDocuments(response).notes;
    return notes;
  }

  @override
  Future<bool> addNote(NoteModel note) async {
    bool noteAdded = await _client.addNote(note);
    return noteAdded;
  }

  @override
  Future<bool> updateNote(NoteModel note) async {
    bool noteUpdated = await _client.updateNote(note);
    return noteUpdated;
  }
}
