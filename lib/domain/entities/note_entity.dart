import 'package:flutter/material.dart';

import 'package:allnotes/domain/entities/note_state_entity.dart';

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
    DateTime? modifiedAt,
  })  : createdAt = DateTime.now(),
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

  Map<String, Object?> toFirestore() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "color": color,
      "status": status,
      "createdAt": createdAt,
      "modifiedAt": modifiedAt,
    };
  }
}
