import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/domain/entities/note_state_entity.dart';

class EditNoteParams extends Equatable {
  final int? noteId;
  final String title;
  final String content;
  final Color color;
  final NoteState state;

  const EditNoteParams({
    required this.title,
    required this.content,
    required this.color,
    required this.state,
    this.noteId,
  });

  @override
  List<Object> get props => [title, content, color, state];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'color': color,
      'state': state,
      'id': noteId,
    };
  }
}
