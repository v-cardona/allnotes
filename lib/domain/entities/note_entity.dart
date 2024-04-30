import 'package:flutter/material.dart';

import 'package:allnotes/data/models/note_model.dart';

class NoteEntity {
  final String id;
  final String title;
  final String content;
  final Color color;
  final NoteState status;
  final DateTime createdAt;
  final DateTime modifiedAt;

  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    this.status = NoteState.unspecified,
    DateTime? createAt,
    DateTime? modifiedAt,
  })  : createdAt = createAt ?? DateTime.now(),
        modifiedAt = modifiedAt ?? DateTime.now();

  NoteEntity copyWith({
    String? id,
    String? title,
    String? content,
    Color? color,
    NoteState? status,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      status: status ?? this.status,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  factory NoteEntity.fromNoteModel(NoteModel model) {
    return NoteEntity(
        id: model.id ?? '',
        title: model.title,
        content: model.content,
        color: Color(model.color),
        status: NoteState.values[model.statusInt],
        createAt: model.createdAt,
        modifiedAt: model.modifiedAt);
  }
}

enum NoteState {
  unspecified, // por defecto
  pinned, // fijado en la parte superior
  archived, // menu de archivado
  deleted, // papelera
}
