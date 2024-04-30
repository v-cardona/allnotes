import 'package:allnotes/common/constants/notes_constants.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:allnotes/domain/entities/note_state_entity.dart';
import 'package:allnotes/presentation/themes/app_color.dart';

class NoteModel {
  final String? id;
  final String title;
  final String content;
  final int color;
  final int statusInt;
  final DateTime createdAt;
  final DateTime modifiedAt;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.statusInt,
    DateTime? createdAt,
    DateTime? modifiedAt,
  })  : createdAt = DateTime.now(),
        modifiedAt = modifiedAt ?? DateTime.now();

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    int? color,
    int? statusInt,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      statusInt: statusInt ?? this.statusInt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  factory NoteModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NoteModel(
      title: data?[NoteConstants.titleStr],
      content: data?[NoteConstants.contentStr],
      color: data?[NoteConstants.colorStr],
      statusInt: data?[NoteConstants.statusStr],
      createdAt: data?[NoteConstants.createdAtStr].toDate(),
      modifiedAt: data?[NoteConstants.modifiedAtStr].toDate(),
    );
  }

  factory NoteModel.fromNoteEntity(NoteEntity note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      color: note.color.value,
      statusInt: note.status.index,
      createdAt: note.createdAt,
      modifiedAt: note.modifiedAt,
    );
  }

  factory NoteModel.firstNote() {
    return NoteModel(
      title: 'Untitled',
      content: 'This is your first note',
      color: AppColor.noteColorDefault.value,
      statusInt: NoteStateEntity().getEnumValue(NoteState.unspecified),
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      NoteConstants.titleStr: title,
      NoteConstants.contentStr: content,
      NoteConstants.colorStr: color,
      NoteConstants.statusStr: statusInt,
      NoteConstants.createdAtStr: createdAt,
      NoteConstants.modifiedAtStr: modifiedAt,
    };
  }
}
