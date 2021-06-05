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

  factory NoteModel.fromDocument(QueryDocumentSnapshot document) {
    NoteModel note;
    if (document.exists) {
      Map<String, dynamic> data = document.data();
      Timestamp timestampCreated = data['creation_time'];
      Timestamp timestampModified = data['last_modification_time'];
      note = NoteModel(
          color: Color(data['color'] ?? AppColor.white),
          content: data['content'],
          createdAt: DateTime.tryParse(timestampCreated.toDate().toString()),
          id: document.id,
          modifiedAt: DateTime.tryParse(timestampModified.toDate().toString()),
          state: NoteState.values[data['state']],
          title: data['title']);
    }

    return note;
  }
}
