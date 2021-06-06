import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NoteEntity extends Equatable {
  final String content;
  final Color color;
  final DateTime createdAt;
  final String id;
  final DateTime modifiedAt;
  final NoteState state;
  final String title;

  NoteEntity(
      {this.content,
      this.color,
      this.id,
      this.title,
      NoteState state,
      DateTime createdAt,
      DateTime modifiedAt})
      : this.state = state ?? NoteState.unspecified,
        this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now();

  @override
  List<Object> get props => [this.id, this.title];
}

enum NoteState { unspecified, pinned, archived, deleted }
