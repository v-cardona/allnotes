import 'package:cloud_firestore/cloud_firestore.dart';

import 'note_model.dart';

class NotesResultModel {
  List<NoteModel> notes;

  NotesResultModel({
    this.notes,
  });

  NotesResultModel.fromDocuments(List<QueryDocumentSnapshot> documents) {
    notes = new List<NoteModel>();
    if (documents.isNotEmpty) {
      notes = new List<NoteModel>();
      documents.forEach((document) {
        notes.add(new NoteModel.fromDocument(document));
      });
    }
  }
}
