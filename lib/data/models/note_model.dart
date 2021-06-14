import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteModel extends NoteEntity {
  final Color color;
  final String content;
  final DateTime createdAt;
  final String id;
  final DateTime modifiedAt;
  final NoteState state;
  final String title;

  NoteModel({
    this.color,
    this.content,
    this.createdAt,
    this.id,
    this.modifiedAt,
    this.state,
    this.title,
  }) : super(
            color: color,
            content: content,
            createdAt: createdAt,
            id: id,
            modifiedAt: modifiedAt,
            state: state,
            title: title);

  factory NoteModel.fromNoteEntity(NoteEntity note) {
    NoteModel noteModel;
    if (note != null) {
      noteModel = NoteModel(
          color: note.color,
          content: note.content,
          createdAt: note.createdAt,
          id: note.id,
          modifiedAt: note.modifiedAt,
          state: note.state,
          title: note.title);
    }

    return noteModel;
  }

  factory NoteModel.fromDocument(QueryDocumentSnapshot document) {
    NoteModel note;
    if (document.exists) {
      Map<String, dynamic> data = document.data();
      Timestamp timestampCreated = data['creation_time'];
      Timestamp timestampModified = data['last_modification_time'];
      note = NoteModel(
          color: Color(data['color'] ?? AppColor.noteColorDefault),
          content: data['content'],
          createdAt: DateTime.tryParse(timestampCreated.toDate().toString()),
          id: document.id,
          modifiedAt: DateTime.tryParse(timestampModified.toDate().toString()),
          state: NoteState.values[data['state']],
          title: data['title']);
    }

    return note;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = color.value;
    data['content'] = content;
    data['creation_time'] = Timestamp.fromDate(createdAt);
    data['last_modification_time'] = Timestamp.fromDate(modifiedAt);
    data['state'] = state.index;
    data['title'] = title;
    return data;
  }
}
