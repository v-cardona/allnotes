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
      this.state,
      this.title,
      DateTime createdAt,
      DateTime modifiedAt})
      : this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now(),
        assert(id != null, 'Note id must not be null');

  @override
  List<Object> get props => [this.id, this.title];
}

enum NoteState { unspecified, pinned, archived, deleted }
