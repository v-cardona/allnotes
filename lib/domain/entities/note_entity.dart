import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      this.id,
      this.title,
      Color color,
      NoteState state,
      DateTime createdAt,
      DateTime modifiedAt})
      : this.color = color ?? AppColor.white,
        this.state = state ?? NoteState.unspecified,
        this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now();

  @override
  List<Object> get props => [this.id, this.title];

  /// Formatted last modified time
  String get strLastModified => DateFormat.MMMd().format(modifiedAt);

  /// Checks if a note in this state can edit (modify / copy).
  bool get canEdit => this.state.index < NoteState.deleted.index;
}

enum NoteState { unspecified, pinned, archived, deleted }
