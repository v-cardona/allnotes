import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:allnotes/data/models/note_model.dart';

class FirebaseClient {
  final FirebaseFirestore firestore;

  FirebaseClient() : firestore = FirebaseFirestore.instance;

  CollectionReference getCollection(String collectionName) {
    return firestore.collection(collectionName).withConverter<NoteModel>(
          fromFirestore: NoteModel.fromFirestore,
          toFirestore: (NoteModel note, options) => note.toFirestore(),
        );
  }

  Future<QuerySnapshot<Object?>> getAllDocuments(String collectionName) async {
    final collection = getCollection(collectionName);
    return await collection.get();
  }
}
