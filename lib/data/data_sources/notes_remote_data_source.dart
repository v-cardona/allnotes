import 'package:allnotes/data/core/firestore_client.dart';
import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/data/models/note_result_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteModel>> getAllNotes();
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
}
